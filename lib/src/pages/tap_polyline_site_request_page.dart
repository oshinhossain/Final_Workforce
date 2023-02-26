// import 'dart:io';

// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:workforce/src/config/app_theme.dart';
// import 'package:workforce/src/config/base.dart';
// import 'package:workforce/src/helpers/dialogHelper.dart';
// import 'package:workforce/src/helpers/hex_color.dart';
// import 'package:workforce/src/helpers/k_text.dart';
//  
// import 'package:workforce/src/helpers/render_img.dart';
// import 'package:workforce/src/helpers/render_svg.dart';
// import 'package:workforce/src/helpers/route.dart';
// import 'package:workforce/src/pages/tapped_polyline.dart';
// import 'package:workforce/src/widgets/custom_textfield_vehicle.dart';

// import '../helpers/loading.dart';
// import '../map/dragmarker.dart';
// import '../widgets/custom_textfield_with_dropdown.dart';

// class RequestSiteRelocationPage2 extends StatefulWidget {
//   @override
//   State<RequestSiteRelocationPage2> createState() => _RequestSiteRelocationPage2State();
// }

// class _RequestSiteRelocationPage2State extends State<RequestSiteRelocationPage2> with SingleTickerProviderStateMixin, Base {
//   TabController? _tabController;
//   int _activeIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       vsync: this,
//       length: 3,
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _tabController!.addListener(() {
//       if (_tabController!.indexIsChanging) {
//         setState(() {
//           _activeIndex = _tabController!.index;
//         });
//       }
//     });
//     return Scaffold(
//       // appBar: VAppbar(title: 'Site Locations'),
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           onPressed: () {
//             back();
//           },
//         ),
//         title: KText(
//           text: 'Request Site Relocation',
//           bold: true,
//           fontSize: 16,
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(70),
//           child: Container(
//               width: Get.width,
//               padding: EdgeInsets.symmetric(
//                 vertical: 15,
//                 horizontal: 15,
//               ),
//               decoration: BoxDecoration(
//                 //           border: Border(
//                 //   left: BorderSide( //                   <--- left side
//                 //     color: Colors.black,
//                 //     width: 3.0,
//                 //   ),
//                 //   top: BorderSide( //                    <--- top side
//                 //     color: Colors.black,
//                 //     width: 3.0,
//                 //   ),
//                 // ),
//                 border: Border(
//                   bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
//                   top: BorderSide(width: 1.5, color: Colors.grey.shade300),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   KText(
//                     text: 'Geography',
//                     color: hexToColor('#80939D'),
//                     fontSize: 13,
//                   ),
//                   SizedBox(height: 5),
//                   KText(
//                     text: 'Bagerhat > Bagerhat Sadar > Dema',
//                     color: hexToColor('#515D64'),
//                     fontSize: 15,
//                   )
//                 ],
//               )),
//         ),
//       ),
//       body: Obx(
//         () => SizedBox(
//           height: Get.height,
//           child: Stack(
//             children: [
//               FlutterMap(
//                 mapController: requestSiteLocationsC.kMapControllerSiteLocation,
//                 options: MapOptions(
//                   center: LatLng(23.773229395435163, 90.41131542577997),
//                   zoom: 10,
//                 ),
//                 // nonRotatedChildren: [],
//                 // dfff
//                 children: [
//                   TileLayer(
//                     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     userAgentPackageName: 'com.ctrendssoftware.workforce',
//                   ),
//                   MarkerLayer(
//                     markers: [
//                       Marker(
//                           point: LatLng(23.773229395435163, 90.41131542577997),
//                           builder: (_) {
//                             return GestureDetector(
//                               onTap: () {
//                                 requestSiteLocationsC.isDrag.toggle();
//                               },
//                               child: Icon(
//                                 Icons.circle,
//                                 color: Colors.red,
//                                 size: 10,
//                               ),
//                             );
//                           })
//                     ],
//                   ),
//                 ],
//               ),
//               Positioned(
//                 bottom: 355,
//                 right: 10,
//                 child: InkWell(
//                   onTap: () {
//                     requestSiteLocationsC.isPlotingEnable.toggle();
//                     // requestSiteLocationsC.addDriver.toggle();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(1.5),
//                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                     child: Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
//                       child: RenderSvg(
//                         path: 'my_place_active',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 30,
//                 right: 10,
//                 child: InkWell(
//                   onTap: () {
//                     requestSiteLocationsC.isPlotingEnable.toggle();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(1.5),
//                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                     child: Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         // color: AppTheme.siteLocationSelect ,
//                         color: requestSiteLocationsC.isPlotingEnable.value ? AppTheme.siteLocationSelect : hexToColor('#9BA9B3'),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: RenderSvg(
//                         path: 'filter',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 80,
//                 right: 10,
//                 child: Container(
//                   padding: EdgeInsets.all(1.5),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
//                     child: RenderSvg(
//                       path: 'info-icon',
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 130,
//                 right: 10,
//                 child: Container(
//                   padding: EdgeInsets.all(1.5),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
//                     child: RenderSvg(
//                       path: 'refresh_icon',
//                     ),
//                   ),
//                 ),
//               ),
//               if (requestSiteLocationsC.isPlotingEnable.value)
//                 Positioned(
//                   bottom: 0,
//                   child: Container(
//                     width: Get.width,
//                     padding: EdgeInsets.only(bottom: 45),
//                     decoration: BoxDecoration(
//                       color: hexToColor('#f5f5f5').withOpacity(1),
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                             left: 8,
//                             right: 6,
//                             top: 5,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               KText(
//                                 text: 'Legends ',
//                                 fontSize: 13,
//                                 bold: true,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(
//                                 width: 35,
//                                 height: 32,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     requestSiteLocationsC.isPlotingEnable.toggle();
//                                     requestSiteLocationsC.addDriver.toggle();
//                                   },
//                                   style: ButtonStyle(
//                                     padding: MaterialStateProperty.all(EdgeInsets.all(0)),
//                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                       ),
//                                     ),
//                                   ),
//                                   child: RenderSvg(
//                                     path: 'icon_add_box_button',
//                                     height: 30,
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   requestSiteLocationsC.isBts.value = true;
//                                   requestSiteLocationsC.isBuilding.value = true;
//                                   requestSiteLocationsC.isEPole.value = true;
//                                   requestSiteLocationsC.isFootPrint.value = true;
//                                   requestSiteLocationsC.isOther.value = true;
//                                   requestSiteLocationsC.isPop.value = true;
//                                   requestSiteLocationsC.isTelPole.value = true;
//                                   requestSiteLocationsC.isWifi.value = true;
//                                   requestSiteLocationsC.islightPost.value = true;
//                                   requestSiteLocationsC.isnewPole.value = true;
//                                 },
//                                 child: KText(
//                                   text: '[Select all]',
//                                   color: AppTheme.siteLocationtext,
//                                   bold: true,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   requestSiteLocationsC.isBts.value = false;
//                                   requestSiteLocationsC.isBuilding.value = false;
//                                   requestSiteLocationsC.isEPole.value = false;
//                                   requestSiteLocationsC.isFootPrint.value = false;
//                                   requestSiteLocationsC.isOther.value = false;
//                                   requestSiteLocationsC.isPop.value = false;
//                                   requestSiteLocationsC.isTelPole.value = false;
//                                   requestSiteLocationsC.isWifi.value = false;
//                                   requestSiteLocationsC.islightPost.value = false;
//                                   requestSiteLocationsC.isnewPole.value = false;
//                                 },
//                                 child: KText(
//                                   text: '[Deselect all]',
//                                   bold: true,
//                                   color: AppTheme.siteLocationtext,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () => requestSiteLocationsC.isPlotingEnable.toggle(),
//                                 icon: Icon(Icons.close),
//                                 color: Colors.grey,
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: DottedLine(
//                             dashColor: hexToColor('#D9D9D9'),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 13,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isWifi.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isWifi.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'Wifi AP ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(8)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'wifiap-icon'),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 25,
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.islightPost.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.islightPost.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'Light Post',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(0)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'light-post'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 13,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isPop.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isPop.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'POP ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(1)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'pop-icon'),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 25,
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isBuilding.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isBuilding.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'Building',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(0)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'building'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 13,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isnewPole.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isnewPole.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'New Pole  ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(40)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'new-pole'),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 25,
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isBts.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isBts.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'BTS ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(0)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'BTS'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 13,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isEPole.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isEPole.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Flexible(
//                                       child: KText(
//                                         text: 'Electricity Pole ',
//                                         bold: true,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                     KText(
//                                       text: '(120)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'electricity-pole'),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 25,
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isFootPrint.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isFootPrint.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'Footprints ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(25)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'footprint'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 13,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isTelPole.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isTelPole.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Flexible(
//                                       child: KText(
//                                         text: 'Telephone Pole ',
//                                         bold: true,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                     KText(
//                                       text: '(82)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'telephone-pole'),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 25,
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: ClipRRect(
//                                         clipBehavior: Clip.hardEdge,
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         child: Checkbox(
//                                           checkColor: hexToColor('#84BEF3'),
//                                           activeColor: Colors.transparent,
//                                           value: requestSiteLocationsC.isOther.value,
//                                           onChanged: (_) {
//                                             requestSiteLocationsC.isOther.toggle();
//                                           },
//                                           side: MaterialStateBorderSide.resolveWith((states) {
//                                             if (states.contains(MaterialState.pressed)) {
//                                               return BorderSide(color: Colors.red);
//                                             } else {
//                                               return BorderSide(color: hexToColor('#84BEF3'));
//                                             }
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: 'Others ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     KText(
//                                       text: '(0)',
//                                       color: AppTheme.siteLocationSelect,
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                     Spacer(),
//                                     RenderSvg(path: 'others'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               if (requestSiteLocationsC.addDriver.value)
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     //color: Colors.pink,
//                     color: Colors.white,
//                     // height: 300,
//                     padding: EdgeInsets.only(bottom: 50),
//                     width: Get.width,
//                     child: Column(
//                       children: [
//                         Material(
//                           color: hexToColor('#D9D9D9'),
//                           child: Container(
//                             height: 57,
//                             padding: EdgeInsets.only(
//                               left: 29.0,
//                               top: 8.0,
//                               right: 29.0,
//                               bottom: 0.0,
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 6,
//                                   width: 50,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30),
//                                     color: hexToColor('#B1B1B1'),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Container(
//                                   height: 35,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.5),
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(5.0),
//                                       topRight: Radius.circular(5.0),
//                                     ),
//                                   ),
//                                   child: _tabBar,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: Get.width,
//                           height: 243,
//                           child: TabBarView(
//                             controller: _tabController,
//                             children: [
//                               requestSiteLocationsC.isDrag.value ? JustificationDrag() : Justification(),
//                               SiteList(),
//                               Evidence(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   TabBar get _tabBar => TabBar(
//         controller: _tabController,
//         labelColor: Colors.blue,
//         labelStyle: TextStyle(
//           fontFamily: 'Manrope',
//           fontSize: 14.0,
//           color: Colors.amber,
//           fontWeight: FontWeight.w700,
//         ),
//         labelPadding: EdgeInsets.all(0),
//         indicator: BoxDecoration(
//           borderRadius: _activeIndex == 0
//               ? BorderRadius.only(topLeft: Radius.circular(5.0))
//               : _activeIndex == 1
//                   ? BorderRadius.only(topRight: Radius.circular(0.0))
//                   : _activeIndex == 2
//                       ? BorderRadius.only(topRight: Radius.circular(5.0))
//                       : null,
//           color: Colors.white,
//         ),
//         indicatorWeight: 1,
//         indicatorColor: Colors.white,
//         indicatorSize: TabBarIndicatorSize.tab,
//         unselectedLabelColor: hexToColor('#41525A'),
//         unselectedLabelStyle: TextStyle(
//           fontFamily: 'Manrope',
//           fontSize: 14.0,
//           fontWeight: FontWeight.w400,
//         ),
//         isScrollable: false,
//         physics: BouncingScrollPhysics(),
//         tabs: [
//           Tab(text: 'Justification'),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border(
//                 left: BorderSide(width: 1, color: hexToColor('#EEF0F6')),
//               ),
//             ),
//             child: Tab(text: 'Site List'),
//           ),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border(
//                 left: BorderSide(width: 1, color: hexToColor('#EEF0F6')),
//               ),
//             ),
//             child: Tab(text: 'Evidence'),
//           ),
//         ],
//       );
// }

// class Justification extends StatefulWidget {
//   @override
//   State<Justification> createState() => _JustificationState();
// }

// class _JustificationState extends State<Justification> with Base {
//   String dropdownvalue = 'Pole';
//   String dropdown = 'Electricity Pole';
//   var items = [
//     'Electricity Pole',
//     'Wifi AP',
//     'New Pole',
//     'Others',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               top: 10,
//             ),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 35,
//                   height: 32,
//                   child: TextButton(
//                     onPressed: () {
//                       requestSiteLocationsC.isPlotingEnable.toggle();
//                       requestSiteLocationsC.addDriver.toggle();
//                     },
//                     style: ButtonStyle(
//                       padding: MaterialStateProperty.all(EdgeInsets.all(0)),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                     ),
//                     child: RenderSvg(
//                       path: 'icon_add_box_button',
//                       height: 30,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 KText(
//                   text: 'Add Site ',
//                   fontSize: 14,
//                   bold: true,
//                   color: Colors.black,
//                 ),

//                 // IconButton(
//                 //   onPressed: () => siteLocationsC
//                 //       .isPlotingEnable
//                 //       .toggle(),
//                 //   icon: Icon(Icons.close),
//                 //   color: Colors.grey,
//                 // )
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: DottedLine(
//               dashColor: hexToColor('#D9D9D9'),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: 160,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         top: 0,
//                       ),
//                       child: CustomTextFieldVegicle(
//                         title: 'Site Type ',
//                         isRequired: false,
//                         suffix: DropdownButton(
//                           underline: Container(),
//                           value: dropdown,
//                           icon: Icon(
//                             Icons.keyboard_arrow_down,
//                             color: hexToColor('#80939D'),
//                           ),
//                           items: items.map((String items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: SizedBox(
//                                 child: Row(
//                                   children: [
//                                     RenderSvg(
//                                       path: 'electricity-pole',
//                                       width: 13,
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     KText(
//                                       text: items,
//                                       fontSize: 15,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               dropdown = newValue!;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   KText(
//                     text: 'Location (Lat, Lon)',
//                     fontSize: 13,
//                   ),
//                   KText(
//                     text: '23.831725, 90.405489',
//                     fontSize: 14,
//                     color: hexToColor(
//                       '#FFA133',
//                     ),
//                   )
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   KText(
//                     text: 'Site ID',
//                     color: AppTheme.appTextColor1,
//                     fontSize: 13,
//                   ),
//                   KText(
//                     text: '965290',
//                     fontSize: 13,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       requestSiteLocationsC.isPlotingEnable.toggle();
//                       requestSiteLocationsC.addDriver.toggle();
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(
//                         top: 90,
//                       ),
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         color: hexToColor('#007BEC'),
//                       ),
//                       child: Center(
//                         child: KText(
//                           text: 'Submit',
//                           color: Colors.white,
//                           bold: true,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class JustificationDrag extends StatelessWidget with Base {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//               top: 10,
//             ),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 35,
//                   height: 32,
//                   child: TextButton(
//                     onPressed: () {
//                       requestSiteLocationsC.isPlotingEnable.toggle();
//                       requestSiteLocationsC.addDriver.toggle();
//                     },
//                     style: ButtonStyle(
//                       padding: MaterialStateProperty.all(EdgeInsets.all(0)),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                     ),
//                     child: RenderSvg(
//                       path: 'arrow_drag',
//                       height: 30,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 KText(
//                   text: 'Drag to Relocate Site ',
//                   fontSize: 14,
//                   bold: true,
//                   color: Colors.black,
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: DottedLine(
//               dashColor: hexToColor('#D9D9D9'),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   KText(text: 'Site Type '),
//                   Row(
//                     children: [
//                       RenderSvg(
//                         path: 'electricity-pole',
//                         width: 13,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       KText(
//                         text: 'Electricity Pole',
//                         fontSize: 15,
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                     child: KText(
//                       text: 'Location (Lat, Lon)',
//                       fontSize: 13,
//                     ),
//                   ),
//                   KText(
//                     text: '23.831725, 90.405489',
//                     fontSize: 14,
//                     color: hexToColor(
//                       '#FFA133',
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: RenderSvg(
//                       path: 'del',
//                       height: 30,
//                     ),
//                   )
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   KText(
//                     text: 'Site ID',
//                     color: AppTheme.appTextColor1,
//                     fontSize: 13,
//                   ),
//                   KText(
//                     text: '965290',
//                     fontSize: 13,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       requestSiteLocationsC.isPlotingEnable.toggle();
//                       requestSiteLocationsC.addDriver.toggle();
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(
//                         top: 90,
//                       ),
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         color: hexToColor('#007BEC'),
//                       ),
//                       child: Center(
//                         child: KText(
//                           text: 'Submit',
//                           color: Colors.white,
//                           bold: true,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SiteList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       // height: Get.height,
//       padding: EdgeInsets.symmetric(horizontal: 6),
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: Get.width,
//               height: 60,
//               margin: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//                 right: 10,
//               ),
//               padding: EdgeInsets.only(left: 10, top: 10, right: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site Type'),
//                       Row(
//                         children: [
//                           RenderSvg(
//                             path: 'electricity-pole',
//                             width: 14,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           KText(
//                             text: 'Electricity Pole',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site ID'),
//                       KText(
//                         text: '965290',
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 25,
//                     width: 80,
//                     margin: EdgeInsets.only(
//                       top: 5,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                         color: Colors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     child: Center(
//                         child: KText(
//                       text: 'Relocate',
//                       bold: true,
//                       color: Colors.blue,
//                     )),
//                   )
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: Colors.blue,
//                   width: 1,
//                 ),
//               ),
//             ),
//             Container(
//               width: Get.width,
//               height: 60,
//               margin: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//                 right: 10,
//               ),
//               padding: EdgeInsets.only(left: 10, top: 10, right: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site Type'),
//                       Row(
//                         children: [
//                           RenderSvg(
//                             path: 'electricity-pole',
//                             width: 14,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           KText(
//                             text: 'Electricity Pole',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site ID'),
//                       KText(
//                         text: '965290',
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 25,
//                     width: 80,
//                     margin: EdgeInsets.only(
//                       top: 5,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                         color: hexToColor('#FF3C3C'),
//                         width: 1,
//                       ),
//                     ),
//                     child: Center(
//                         child: KText(
//                       text: 'Drop',
//                       bold: true,
//                       color: hexToColor('#FF3C3C'),
//                     )),
//                   )
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: hexToColor('#FF3C3C'),
//                   width: 1,
//                 ),
//               ),
//             ),
//             Container(
//               width: Get.width,
//               height: 60,
//               margin: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//                 right: 10,
//               ),
//               padding: EdgeInsets.only(left: 10, top: 10, right: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site Type'),
//                       Row(
//                         children: [
//                           RenderSvg(
//                             path: 'electricity-pole',
//                             width: 14,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           KText(
//                             text: 'Electricity Pole',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site ID'),
//                       KText(
//                         text: '965290',
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 25,
//                     width: 80,
//                     margin: EdgeInsets.only(
//                       top: 5,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                         color: Colors.blue,
//                         width: 1,
//                       ),
//                     ),
//                     child: Center(
//                         child: KText(
//                       text: 'Relocate',
//                       bold: true,
//                       color: Colors.blue,
//                     )),
//                   )
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: Colors.blue,
//                   width: 1,
//                 ),
//               ),
//             ),
//             Container(
//               width: Get.width,
//               height: 60,
//               margin: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//                 right: 10,
//               ),
//               padding: EdgeInsets.only(left: 10, top: 10, right: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site Type'),
//                       Row(
//                         children: [
//                           RenderSvg(
//                             path: 'electricity-pole',
//                             width: 14,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           KText(
//                             text: 'Electricity Pole',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       KText(text: 'Site ID'),
//                       KText(
//                         text: '965290',
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 25,
//                     width: 80,
//                     margin: EdgeInsets.only(
//                       top: 5,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                         color: hexToColor('#00D8A0'),
//                         width: 1,
//                       ),
//                     ),
//                     child: Center(
//                         child: KText(
//                       text: 'New',
//                       bold: true,
//                       color: hexToColor('#00D8A0'),
//                     )),
//                   )
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: hexToColor('#00D8A0'),
//                   width: 1,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Evidence extends StatelessWidget with Base {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.only(top: 15, left: 15, right: 15),
//         child: Column(
//           children: [
//             ListView.builder(
//               itemCount: 1,
//               shrinkWrap: true,
//               primary: false,
//               itemBuilder: (BuildContext context, int index) {
//                 // final item =
//                 //     loadMaterialsToVehicleC.transportOrderVehicle[index];
//                 return Obx(
//                   () => Container(
//                     margin: EdgeInsets.only(
//                       bottom: 15,
//                     ),
//                     width: double.maxFinite,
//                     decoration: BoxDecoration(
//                       // borderRadius: BorderRadius.all(Radius.circular(5)),
//                       borderRadius: BorderRadius.all(Radius.circular(5)),
//                       border: Border.all(width: 1, color: hexToColor('#FFE9CF')),
//                       color: hexToColor('#FFFFFF'),
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 34,
//                           width: double.infinity,
//                           // color: hexToColor('#FFE9CF'),
//                           decoration: BoxDecoration(
//                             // borderRadius: BorderRadius.all(Radius.circular(5)),
//                             borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
//                             color: hexToColor('#FFE9CF'),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Row(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 14,
//                                       ),
//                                       RenderSvg(
//                                         path: 'electricity-pole',
//                                         width: 15,
//                                       ),
//                                       // SvgPicture.asset(
//                                       //     '${Constants.svgPath}/trucklogo.svg'),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       KText(
//                                         text: 'Electricity Pole [965290]',
//                                         fontSize: 16,
//                                         color: hexToColor('#41525A'),
//                                         bold: true,
//                                       ),
//                                     ],
//                                   ),
//                                   Spacer(),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 10),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         requestSiteRelocationC.pickMultiImage();
//                                       },
//                                       child: RenderSvg(path: 'icon_add_box'),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               requestSiteRelocationC.imagefiles.isEmpty
//                                   ? SizedBox()
//                                   : GridView.builder(
//                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                       ),
//                                       itemCount: requestSiteRelocationC.imagefiles.length,
//                                       primary: false,
//                                       shrinkWrap: true,
//                                       itemBuilder: (BuildContext context, int index) {
//                                         final item = requestSiteRelocationC.imagefiles[index];
//                                         return Stack(
//                                           children: [
//                                             Container(
//                                               width: double.infinity,
//                                               margin: EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(5),
//                                               ),
//                                               child: ClipRRect(
//                                                 borderRadius: BorderRadius.circular(5),
//                                                 child: Image.file(
//                                                   File(item.path),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               top: 0,
//                                               right: 0,
//                                               left: 0,
//                                               bottom: 0,
//                                               child: InkWell(
//                                                 onTap: () {
//                                                   requestSiteRelocationC.imagefiles.removeAt(index);
//                                                 },
//                                                 child: Container(
//                                                   margin: EdgeInsets.all(60),
//                                                   decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(50),
//                                                     color: Colors.white.withOpacity(0.5),
//                                                   ),
//                                                   child: Icon(
//                                                     Icons.delete,
//                                                     color: Colors.redAccent,
//                                                     size: 30,
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       },
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TapRequestSiteRelocationPage extends StatefulWidget {
//   @override
//   State<TapRequestSiteRelocationPage> createState() => _TapRequestSiteRelocationPageState();
// }

// class _TapRequestSiteRelocationPageState extends State<TapRequestSiteRelocationPage> with SingleTickerProviderStateMixin, Base {
//   TabController? _tabController;
//   int _activeIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       vsync: this,
//       length: 3,
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     requestSiteRelocationC.disposeData();
//     _tabController!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _tabController!.addListener(() {
//       if (_tabController!.indexIsChanging) {
//         setState(() {
//           _activeIndex = _tabController!.index;
//         });
//       }
//     });
//     requestSiteRelocationC.getProjectName();

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           onPressed: () {
//             back();
//           },
//         ),
//         title: KText(
//           text: 'Setup Project Sites',
//           bold: true,
//           fontSize: 16,
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(100),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
//                 top: BorderSide(width: 1.5, color: Colors.grey.shade300),
//               ),
//             ),
//             child: Obx(
//               () => Column(
//                 children: [
//                   SizedBox(height: 3),
//                   if (requestSiteRelocationC.projectNameList.isNotEmpty)
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 12.0),
//                       child: CustomTextFieldWithDropdown(
//                         suffix: DropdownButton(
//                           value: requestSiteRelocationC.selectedProject.value!.projectName,
//                           underline: Container(),
//                           icon: Icon(
//                             Icons.keyboard_arrow_down,
//                             color: hexToColor('#80939D'),
//                           ),
//                           items: requestSiteRelocationC.projectNameList.map((item) {
//                             return DropdownMenuItem(
//                               onTap: () {
//                                 requestSiteRelocationC.selectedProject.value = item;
//                               },
//                               value: item.projectName,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   right: 35,
//                                 ),
//                                 child: SizedBox(
//                                   width: Get.width / 1.3,
//                                   child: KText(
//                                     text: item.projectName,
//                                     fontSize: 13,
//                                     maxLines: 2,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (item) {
//                             //// kLog('value');
//                           },
//                         ),
//                       ),
//                     ),
//                   // Padding(
//                   //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //     children: [
//                   //       Column(
//                   //         mainAxisAlignment: MainAxisAlignment.start,
//                   //         crossAxisAlignment: CrossAxisAlignment.start,
//                   //         children: [
//                   //           KText(
//                   //             text: 'Area Type',
//                   //             color: hexToColor('#80939D'),
//                   //             fontSize: 13,
//                   //           ),
//                   //           KText(
//                   //             text: 'Country Unit',
//                   //             color: hexToColor('#515D64'),
//                   //             fontSize: 14,
//                   //           ),
//                   //         ],
//                   //       ),
//                   //       Column(
//                   //         mainAxisAlignment: MainAxisAlignment.end,
//                   //         crossAxisAlignment: CrossAxisAlignment.end,
//                   //         children: [
//                   //           KText(
//                   //             text: 'Level',
//                   //             color: hexToColor('#80939D'),
//                   //             fontSize: 13,
//                   //           ),
//                   //           KText(
//                   //             text: '4',
//                   //             color: hexToColor('#515D64'),
//                   //             fontSize: 14,
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),

//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Row(
//                               children: [
//                                 KText(
//                                   text: 'Geography',
//                                   color: hexToColor('#80939D'),
//                                   fontSize: 13,
//                                 ),
//                                 KText(
//                                   text: '*',
//                                   color: Colors.red,
//                                   bold: true,
//                                 ),
//                               ],
//                             ),
//                             SizedBox(width: 10),
//                             GestureDetector(
//                               onTap: requestSiteRelocationC.searchLocationBottomSheet,
//                               child: RenderSvg(
//                                 path: 'icon_search_user',
//                                 height: 20.0,
//                                 width: 20.0,
//                                 color: Color(0xff9BA9B3),
//                               ),
//                             )
//                           ],
//                         ),
//                         if (requestSiteRelocationC.siteLocations.value != null)
//                           KText(
//                             text: requestSiteRelocationC.siteLocations.value == null
//                                 ? ''
//                                 : '${requestSiteRelocationC.siteLocations.value!.geoLevel2Name} > ${requestSiteRelocationC.siteLocations.value!.geoLevel3Name} > ${requestSiteRelocationC.siteLocations.value!.geoLevel4Name}',
//                             maxLines: 3,
//                           ),
//                       ],
//                     ),
//                   ),

//                   Divider(
//                     height: 1,
//                     color: hexToColor('#80939D'),
//                   ),

//                   // Padding(
//                   //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   //   child: Row(
//                   //     children: [
//                   //       Icon(
//                   //         Icons.share,
//                   //         color: Colors.amber,
//                   //       ),
//                   //       SizedBox(
//                   //         width: 10,
//                   //       ),
//                   //       KText(
//                   //         text: 'Topology on Map',
//                   //         fontSize: 18,
//                   //         color: hexToColor('#41525A'),
//                   //       )
//                   //     ],
//                   //   ),
//                   // ),

//                   // Padding(
//                   //   padding: EdgeInsets.all(8.0),
//                   //   child: Row(
//                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       children: [
//                   //         Expanded(
//                   //           child: KText(
//                   //               text: requestSiteRelocationC
//                   //                           .siteLocationsV2.value ==
//                   //                       null
//                   //                   ? ''
//                   //                   : '${requestSiteRelocationC.siteLocationsV2.value!.commonFields!.level2name} > ${requestSiteRelocationC.siteLocationsV2.value!.commonFields!.level3name} > ${requestSiteRelocationC.siteLocationsV2.value!.commonFields!.level4name}'),
//                   //         ),
//                   //         Padding(
//                   //           padding: EdgeInsets.only(right: 10),
//                   //           child: GestureDetector(
//                   //             onTap:
//                   //                 requestSiteRelocationC.searchLocationBottomSheet,
//                   //             child: RenderSvg(
//                   //               path: 'icon_search_user',
//                   //               height: 20.0,
//                   //               width: 20.0,
//                   //               color: Color(0xff9BA9B3),
//                   //             ),
//                   //           ),
//                   //         )
//                   //       ]),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Obx(
//         () => Stack(
//           children: [
//             FlutterMap(
//               mapController: requestSiteRelocationC.kMapControllerSiteLocation,
//               options: MapOptions(
//                 absorbPanEventsOnScrollables: false,
//                 center: LatLng(23.5414747089055, 90.78792035579683),
//                 zoom: 13,
//                 maxZoom: 90,
//                 onTap: (tapPosition, latLng) {
//                  // kLog(latLng);
//                   if (requestSiteRelocationC.addMarker.value) {
//                     requestSiteRelocationC.addProject(latLng);
//                   }
//                 },
//               ),
//               children: [
//                 // ---------------google Satellite Map view -------------------
//                 TileLayer(
//                   urlTemplate: requestSiteRelocationC.isSateliteViewEnable.value
//                       ? 'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}'
//                       : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   userAgentPackageName: 'com.ctrendssoftware.workforce',
//                 ),

//                 // =========== To show current location on map ===============
//                 CircleLayer(
//                   circles: requestSiteRelocationC.currentLocationCircleMarker,
//                 ),

//                 //================== Draw area polygon =====================

//                 PolygonLayer(
//                   polygonCulling: false,
//                   polygons: [
//                     Polygon(
//                       points: requestSiteRelocationC.pointsForPolygon,
//                       // color: Colors.blue,
//                       borderStrokeWidth: 3,
//                       borderColor: hexToColor('#00D8A0'),
//                       // color: hexToColor('#e6f2d9').withOpacity(.8),
//                       // isFilled: true,
//                     ),
//                   ],
//                 ),

//                 TappablePolylineLayerOptions(
//                   polylineCulling: false,
//                   polylines: requestSiteRelocationC.linkPolylines,
//                   onTap: () {
//                    // kLog('tapped polyline');
//                     DialogHelper.successDialog(
//                       title: 'Success!',
//                       msg: 'polyline tapped',
//                       color: hexToColor('#00B485'),
//                       path: 'success-circular',
//                       onPressed: () {
//                         // offAll(MainPage());
//                         // newSite.clear();
//                         back();
//                       },
//                     );
//                   },
//                 ),

//                 // MarkerLayer(markers: requestSiteRelocationC.markers),
//                 requestSiteRelocationC.editMarker.value
//                     ? DragMarkers(
//                         markers: requestSiteRelocationC.projectSiteMarkers2,
//                       )
//                     : MarkerLayer(markers: requestSiteRelocationC.projectSiteMarkers),
//                 requestSiteRelocationC.deleteMarker.value
//                     ? MarkerLayer(
//                         markers: requestSiteRelocationC.projectSiteDropMarkers,
//                       )
//                     : MarkerLayer(markers: requestSiteRelocationC.projectSiteMarkers),

//                 DragMarkers(
//                   markers: requestSiteRelocationC.addProjectSiteMarkers,
//                 ),
//                 // MarkerLayer(markers: requestSiteRelocationC.projectSiteMarkers),
//               ],
//             ),
//             if (requestSiteRelocationC.isLoading.value) Positioned(top: 150, right: 150, child: Loading()),
//             Positioned(
//               top: 30,
//               right: 10,
//               child: InkWell(
//                 onTap: () {},
//                 child: Container(
//                   padding: EdgeInsets.all(1.5),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       // color: AppTheme.siteLocationSelect ,
//                       color: hexToColor('#9BA9B3'),
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: RenderSvg(
//                       path: 'filter',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 80,
//               right: 10,
//               child: InkWell(
//                 onTap: () {
//                   if (requestSiteRelocationC.addDriver.value) {
//                     requestSiteRelocationC.addDriver.toggle();
//                   } else {
//                     requestSiteRelocationC.isPlotingEnable.toggle();
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(1.5),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: requestSiteRelocationC.isPlotingEnable.value || requestSiteRelocationC.addDriver.value
//                           ? AppTheme.siteLocationSelect
//                           : hexToColor('#9BA9B3'),
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: RenderSvg(
//                       path: 'info-icon',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 130,
//               right: 10,
//               child: InkWell(
//                 onTap: () {},
//                 child: Container(
//                   padding: EdgeInsets.all(1.5),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
//                     child: RenderSvg(
//                       path: 'refresh_icon',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 180,
//               right: 10,
//               child: InkWell(
//                 onTap: () {
//                   requestSiteRelocationC.isSateliteViewEnable.toggle();
//                   // requestSiteRelocationC.getAreaByIds();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(1.5),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
//                     child: Icon(
//                       Icons.map,
//                       color: requestSiteRelocationC.isSateliteViewEnable.value ? null : Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               // bottom: 0,
//               top: 230,
//               right: 10,
//               child: InkWell(
//                 onTap: () {
//                   requestSiteRelocationC.showCurrentLocationOnMap();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(1.5),
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
//                   child: Container(
//                     padding: EdgeInsets.all(2),
//                     decoration: BoxDecoration(color: hexToColor('#9BA9B3'), borderRadius: BorderRadius.circular(50)),
//                     child: RenderSvg(
//                       path: 'my_place_active',
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             if (requestSiteRelocationC.isPlotingEnable.value)
//               Positioned(
//                 bottom: 0,
//                 child: Container(
//                   width: Get.width,
//                   // height: 350,
//                   decoration: BoxDecoration(
//                     color: hexToColor('#f5f5f5').withOpacity(1),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(
//                           left: 8,
//                           right: 6,
//                           top: 5,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             KText(
//                               text: '',
//                               fontSize: 13,
//                               bold: true,
//                               color: Colors.black,
//                             ),
//                             if (requestSiteRelocationC.projectSiteMarkers.isNotEmpty)
//                               SizedBox(
//                                 width: 35,
//                                 height: 32,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     requestSiteRelocationC.addMarkerDialog();
//                                   },
//                                   style: ButtonStyle(
//                                     padding: MaterialStateProperty.all(EdgeInsets.all(0)),
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                         side: BorderSide(
//                                           width: 1.5,
//                                           color: Colors.blueAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   child: RenderSvg(
//                                     path: 'add_driver',
//                                     height: 20,
//                                     color: Colors.blueAccent,
//                                   ),
//                                 ),
//                               ),
//                             if (requestSiteRelocationC.projectSiteMarkers.isNotEmpty)
//                               SizedBox(
//                                 width: 35,
//                                 height: 32,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     requestSiteRelocationC.addMarker.value = false;
//                                     requestSiteRelocationC.deleteMarker.value = false;

//                                     requestSiteRelocationC.editMarker.toggle();
//                                     if (requestSiteRelocationC.editMarker.value) {
//                                       requestSiteRelocationC.siteSearchV2();
//                                     }
//                                   },
//                                   style: ButtonStyle(
//                                     padding: MaterialStateProperty.all(EdgeInsets.all(0)),
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                         side: BorderSide(
//                                           width: 1.5,
//                                           color: requestSiteRelocationC.editMarker.value ? Colors.greenAccent : Colors.blueAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   child: Icon(
//                                     Icons.offline_share,
//                                     color: requestSiteRelocationC.editMarker.value ? Colors.greenAccent : Colors.blueAccent,
//                                   ),
//                                 ),
//                               ),
//                             if (requestSiteRelocationC.projectSiteMarkers.isNotEmpty && requestSiteRelocationC.newSite.isNotEmpty)
//                               SizedBox(
//                                 width: 35,
//                                 height: 32,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     requestSiteRelocationC.relocationSite('relocate');
//                                   },
//                                   style: ButtonStyle(
//                                     padding: MaterialStateProperty.all(EdgeInsets.all(0)),
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                         side: BorderSide(
//                                           width: 1.5,
//                                           color: Colors.blueAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   child: Icon(Icons.done_sharp
//                                       // path: 'add_driver',
//                                       // height: 20,
//                                       // color: Colors.blueAccent,
//                                       ),
//                                 ),
//                               ),
//                             if (requestSiteRelocationC.projectSiteMarkers.isNotEmpty)
//                               SizedBox(
//                                 width: 35,
//                                 height: 32,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     requestSiteRelocationC.addMarker.value = false;
//                                     requestSiteRelocationC.editMarker.value = false;
//                                     requestSiteRelocationC.deleteMarker.toggle();
//                                     if (requestSiteRelocationC.deleteMarker.value) {
//                                       requestSiteRelocationC.siteSearchV2();
//                                     }
//                                   },
//                                   style: ButtonStyle(
//                                     padding: MaterialStateProperty.all(EdgeInsets.all(0)),
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(5.0),
//                                         side: BorderSide(
//                                           width: 1.5,
//                                           color: requestSiteRelocationC.deleteMarker.value ? Colors.red : Colors.blueAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   child: RenderSvg(
//                                     path: 'icon_delete',
//                                     height: 30,
//                                     color: requestSiteRelocationC.deleteMarker.value ? Colors.red : Colors.blueAccent,
//                                   ),
//                                 ),
//                               ),
//                             IconButton(
//                               onPressed: () => requestSiteRelocationC.isPlotingEnable.toggle(),
//                               icon: Icon(Icons.close),
//                               color: Colors.grey,
//                             )
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: DottedLine(
//                           dashColor: hexToColor('#D9D9D9'),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 13,
//                       ),
//                       // Container(
//                       //   padding: EdgeInsets.symmetric(horizontal: 16),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //     children: [
//                       //       Expanded(
//                       //         child: Row(
//                       //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //           children: [
//                       //             SizedBox(
//                       //               width: 5,
//                       //             ),
//                       //             KText(
//                       //               text: 'Fiber Link ',
//                       //               bold: true,
//                       //               fontSize: 14,
//                       //             ),
//                       //             KText(
//                       //               text:
//                       //                   //  '(${requestSiteRelocationC.ofcLength.value.round().ceilToDouble()} Km)',
//                       //                   '(${requestSiteRelocationC.ofcLength.value.toStringAsFixed(2)} Km)',
//                       //               color: AppTheme.siteLocationSelect,
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             Spacer(),
//                       //             // RenderSvg(path: 'wifiap-icon'),
//                       //           ],
//                       //         ),
//                       //       ),
//                       //       SizedBox(
//                       //         width: 20,
//                       //       ),
//                       //       Expanded(
//                       //         child: Row(
//                       //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //           children: [
//                       //             SizedBox(
//                       //               width: 5,
//                       //             ),
//                       //             KText(
//                       //               text: '12 Core ',
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             KText(
//                       //               text:
//                       //                   '(${requestSiteRelocationC.ofcCore12.value.toStringAsFixed(2)} Km)',
//                       //               color: AppTheme.siteLocationSelect,
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             Spacer(),
//                       //             Container(
//                       //               height: 5,
//                       //               width: 15,
//                       //               color: Colors.green,
//                       //             )
//                       //           ],
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: 13,
//                       // ),
//                       // Container(
//                       //   padding: EdgeInsets.symmetric(horizontal: 16),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //     children: [
//                       //       Expanded(
//                       //         child: Row(
//                       //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //           children: [
//                       //             SizedBox(
//                       //               width: 5,
//                       //             ),
//                       //             KText(
//                       //               text: '4 Core ',
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             KText(
//                       //               text:
//                       //                   '(${requestSiteRelocationC.ofcCore4.value.toStringAsFixed(2)} Km)',
//                       //               color: AppTheme.siteLocationSelect,
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             Spacer(),
//                       //             Container(
//                       //               height: 5,
//                       //               width: 15,
//                       //               color: Colors.blue,
//                       //             )
//                       //           ],
//                       //         ),
//                       //       ),
//                       //       SizedBox(
//                       //         width: 20,
//                       //       ),
//                       //       Expanded(
//                       //         child: Row(
//                       //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //           children: [
//                       //             SizedBox(
//                       //               width: 5,
//                       //             ),
//                       //             KText(
//                       //               text: '24 Core',
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             KText(
//                       //               text:
//                       //                   '(${requestSiteRelocationC.ofcCore24.value.toStringAsFixed(2)} Km)',
//                       //               color: AppTheme.siteLocationSelect,
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             Spacer(),
//                       //             Container(
//                       //               height: 5,
//                       //               width: 15,
//                       //               color: Colors.red,
//                       //             )
//                       //           ],
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: 13,
//                       // ),
//                       // Container(
//                       //   padding: EdgeInsets.symmetric(horizontal: 16),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //     children: [
//                       //       Expanded(
//                       //         child: Row(
//                       //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //           children: [
//                       //             SizedBox(
//                       //               width: 5,
//                       //             ),
//                       //             KText(
//                       //               text: '8 Core ',
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             KText(
//                       //               text:
//                       //                   '(${requestSiteRelocationC.ofcCore8.value.toStringAsFixed(2)} Km)',
//                       //               color: AppTheme.siteLocationSelect,
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             Spacer(),
//                       //             Container(
//                       //               height: 5,
//                       //               width: 15,
//                       //               color: Colors.purple,
//                       //             )
//                       //           ],
//                       //         ),
//                       //       ),
//                       //       SizedBox(
//                       //         width: 20,
//                       //       ),
//                       //       Expanded(
//                       //         child: Row(
//                       //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //           children: [
//                       //             SizedBox(
//                       //               width: 5,
//                       //             ),
//                       //             KText(
//                       //               text: 'Other Cores',
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             KText(
//                       //               text:
//                       //                   '(${requestSiteRelocationC.ofcCoreOthers.value.toStringAsFixed(2)} Km)',
//                       //               color: AppTheme.siteLocationSelect,
//                       //               bold: true,
//                       //               fontSize: 11,
//                       //             ),
//                       //             Spacer(),
//                       //             Container(
//                       //               height: 5,
//                       //               width: 15,
//                       //               color: Colors.orange,
//                       //             )
//                       //           ],
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: 8,
//                       // ),
//                       // Padding(
//                       //   padding: EdgeInsets.symmetric(horizontal: 16),
//                       //   child: DottedLine(
//                       //     dashColor: hexToColor('#D9D9D9'),
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: 8,
//                       // ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'Wifi AP ',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text: '(${requestSiteRelocationC.wifiApCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'wifiap-icon'),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'Light Post',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text: '(${requestSiteRelocationC.lightPostCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'light-post'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 13,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'POP ',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text: '(${requestSiteRelocationC.popCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'pop-icon'),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'Building',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text: '(${requestSiteRelocationC.buildingCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'building'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 13,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'New Pole  ',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text: '(${requestSiteRelocationC.newPoleCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'new-pole'),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'BTS ',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     // text: '(0)',
//                                     text: '(${requestSiteRelocationC.btsCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'BTS'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 13,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Flexible(
//                                     child: KText(
//                                       text: 'Electricity Pole ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                   ),
//                                   KText(
//                                     text: '(${requestSiteRelocationC.elePoleCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'electricity-pole'),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'Footprints ',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text: '(0)',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'footprint'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 13,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Flexible(
//                                     child: KText(
//                                       text: 'Telephone Pole ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                   ),
//                                   KText(
//                                     //  text: '(0)',
//                                     text: '(${requestSiteRelocationC.telPoleCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(
//                                     path: 'telephone-pole',
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'Cable TV Operator ',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text:
//                                         // '(${requestSiteRelocationC.otherMarkers.length})',
//                                         '(${requestSiteRelocationC.cableTvCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderImg(
//                                     path: 'cable_tv.jpeg',
//                                     width: 17,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(
//                         height: 13,
//                       ),

//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Flexible(
//                                     child: KText(
//                                       text: 'Local ISP ',
//                                       bold: true,
//                                       fontSize: 11,
//                                     ),
//                                   ),
//                                   KText(
//                                     //  text: '(0)',
//                                     text: '(${requestSiteRelocationC.localIspCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderImg(
//                                     path: 'local_isp.jpeg',
//                                     width: 17,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   KText(
//                                     text: 'Others ',
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   KText(
//                                     text:
//                                         // '(${requestSiteRelocationC.otherMarkers.length})',
//                                         '(${requestSiteRelocationC.otherPoleCount})',
//                                     color: AppTheme.siteLocationSelect,
//                                     bold: true,
//                                     fontSize: 11,
//                                   ),
//                                   Spacer(),
//                                   RenderSvg(path: 'others'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(
//                         height: 35,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             if (requestSiteRelocationC.addDriver.value)
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   //color: Colors.pink,
//                   color: Colors.white,
//                   // height: 350,
//                   // padding: EdgeInsets.only(bottom: 10),
//                   width: Get.width,
//                   child: Column(
//                     children: [
//                       Material(
//                         color: Colors.grey[200]!.withOpacity(.8),
//                         child: Container(
//                           height: 57,
//                           padding: EdgeInsets.only(
//                             left: 29.0,
//                             top: 8.0,
//                             right: 29.0,
//                             bottom: 0.0,
//                           ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: 6,
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   color: hexToColor('#B1B1B1'),
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Container(
//                                 height: 35,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.5),
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(5.0),
//                                     topRight: Radius.circular(5.0),
//                                   ),
//                                 ),
//                                 child: _tabBar,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: Get.width,
//                         height: 243,
//                         child: TabBarView(
//                           controller: _tabController,
//                           children: [
//                             requestSiteLocationsC.isDrag.value ? JustificationDrag() : Justification(),
//                             SiteList(),
//                             Evidence(),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                     ],
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }

//   TabBar get _tabBar => TabBar(
//         controller: _tabController,
//         labelColor: Colors.blue,
//         labelStyle: TextStyle(
//           fontFamily: 'Manrope',
//           fontSize: 14.0,
//           color: Colors.amber,
//           fontWeight: FontWeight.w700,
//         ),
//         labelPadding: EdgeInsets.all(0),
//         indicator: BoxDecoration(
//           borderRadius: _activeIndex == 0
//               ? BorderRadius.only(topLeft: Radius.circular(5.0))
//               : _activeIndex == 1
//                   ? BorderRadius.only(topRight: Radius.circular(0.0))
//                   : _activeIndex == 2
//                       ? BorderRadius.only(topRight: Radius.circular(5.0))
//                       : null,
//           color: Colors.white,
//         ),
//         indicatorWeight: 1,
//         indicatorColor: Colors.white,
//         indicatorSize: TabBarIndicatorSize.tab,
//         unselectedLabelColor: hexToColor('#41525A'),
//         unselectedLabelStyle: TextStyle(
//           fontFamily: 'Manrope',
//           fontSize: 14.0,
//           fontWeight: FontWeight.w400,
//         ),
//         isScrollable: false,
//         physics: BouncingScrollPhysics(),
//         tabs: [
//           Tab(text: 'Justification'),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border(
//                 left: BorderSide(width: 1, color: hexToColor('#EEF0F6')),
//               ),
//             ),
//             child: Tab(text: 'Site List'),
//           ),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               border: Border(
//                 left: BorderSide(width: 1, color: hexToColor('#EEF0F6')),
//               ),
//             ),
//             child: Tab(text: 'Evidence'),
//           ),
//         ],
//       );
// }
