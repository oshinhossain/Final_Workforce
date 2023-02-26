// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';


// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:workforce/src/config/api_endpoint.dart';
// import 'package:workforce/src/controllers/site_completion_status_controller.dart';
// import 'package:workforce/src/controllers/user_controller.dart';
//  
// import 'package:workforce/src/helpers/render_svg.dart';
// import 'package:workforce/src/models/site_location_v2.dart';
// import 'package:workforce/src/pages/site_completion_status_page.dart';
// import 'package:workforce/src/services/api_service.dart';

// class GoogleMapViewController extends GetxController with ApiService {
// // final kMapControllerSiteLocation = MapController();
//   // final kMapController = GoogleMapsController(
//   //        myLocationEnabled: true,
//   //     trafficEnabled: true,
//   //     buildingsEnabled: true,
//   //     mapToolbarEnabled: true,
//   //     zoomGesturesEnabled: true,
//   //     tiltGesturesEnabled: true,
//   //     myLocationButtonEnabled: true,
//   //     rotateGesturesEnabled: true,
//   //     // indoorViewEnabled: true,
//   //     mapType: MapType.normal,
//   //     initialCameraPosition:
//   //         CameraPosition(target: LatLng(24.802065043097006, 90.41147232055664), zoom: 18),

//   // );
//   final siteLocations = Rx<ProjectSites?>(null);
//   final allMarkers = RxList<Marker>();
//   final projectSiteList = RxList<ProjectSites?>([]);

//   void siteSearchV2() async {
//     try {
//       //  isLoading.value = true;
//       final siteCompletionStatusC = Get.put(SiteCompletionStausController());
//       final username = Get.put(UserController()).username;

//       final body = {
//         'apiKey': ApiEndpoint.KYC_API_KEY,
//         'appCode': ApiEndpoint.WFC_APP_CODE,
//         'username': username,

//         'areaLevelFullCodes': [siteCompletionStatusC.levelFullCode.value],
//         if (siteCompletionStatusC.pId.value.isNotEmpty) 'pId': siteCompletionStatusC.pId.value
//         // // 'areaLevelFullCode': 'BD30261429',
//       };

//      // kLog(body);

//       final res = await postDynamic(path: ApiEndpoint.getSiteUrl(), body: body, authentication: true);
//      // kLog(res.data);
//       // final rawData = res.data['data'];

//       // final projectSites = rawData['projectSites'] as List;
//       // final appliances = rawData['appliances'] as List;
//       // final links = rawData['links'] as List;

//       // newPoleCount.value = 0;
//       // elePoleCount.value = 0;
//       // telPoleCount.value = 0;
//       // lightPostCount.value = 0;
//       // buildingCount.value = 0;
//       // otherPoleCount.value = 0;

//       // wifiApCount.value = 0;
//       // popCount.value = 0;
//       // btsCount.value = 0;

//       //final bounds = LatLngBounds();

//       //================== Project Sites Circles =================

//       final projectSiteListData = res.data['data']
//           .map((json) => ProjectSites.fromJson(json as Map<String, dynamic>))
//           .toList()
//           .cast<ProjectSites>() as List<ProjectSites>;

//       siteLocations.value = null;
//       siteLocations.value = projectSiteListData.first;

//       if (projectSiteListData.isNotEmpty) {
//         projectSiteList.clear();
//         allMarkers.clear();
//         //Add project site
//         projectSiteList.addAll(projectSiteListData);

//         projectSiteListData.forEach((x) {
//           // if (x.pillarType == 'Electricity Pole') {
//           //   elePoleCount.value++;
//           // } else if (x.pillarType == 'New Pole') {
//           //   newPoleCount.value++;
//           // }
//           // // else if (x.pillarType == 'Building/House' ||
//           // //     x.pillarType == 'On Building') {
//           // //   buildingCount.value++;
//           // // }
//           // else if (x.pillarType == 'Light Post') {
//           //   lightPostCount.value++;
//           // } else if (x.pillarType == 'Telephone Pole') {
//           //   telPoleCount.value++;
//           // } else {
//           //   // otherPoleCount.value++;
//           //   buildingCount.value++;
//           // }

//           // if (x.functionType == 'Wifi Router') {
//           //   wifiApCount.value++;
//           // }

//           // if (x.functionType == 'POP') {
//           //   popCount.value++;
//           // }
//           // if (x.functionType == 'BTS') {
//           //   btsCount.value++;
//           // }
//           // if (x.workStatus == 'Completed') {
//           //   // projectSiteList[projectSiteList.indexWhere((element) => element.workStatus==x.workStatus)].
//           //   completeCount.value++;
//           // }
//           // if (x.workStatus == 'Aborted') {
//           //   abortedCount.value++;
//           // }
//           // if (x.workStatus == 'Started' || x.workStatus == 'Restarted' || x.workStatus == 'WIP') {
//           //   wsrCount.value++;
//           // }
//           allMarkers.add(
//             Marker(
//                 position: LatLng(x.latitude!, x.longitude!),
//                 markerId: MarkerId(x.id!),
//                 icon: BitmapDescriptor.fromAssetImage(configuration, assetName),
//                 onTap: () {
//                   siteCompletionStatusC.siteCompletionDialog(x: x);
//                 }
//                 // icon: ,
//                 // builder: (_) {
//                 //   return GestureDetector(
//                 //     onTap: () {
//                 //      siteCompletionStatusC.siteCompletionDialog(x: x);
//                 //     },
//                 //     child: x.functionType == 'Cable Point'
//                 //         ? x.workStatus == 'Completed'
//                 //             ? RenderSvg(
//                 //                 path: x.pillarType == 'Electricity Pole'
//                 //                     ? 'dot-red-complete'
//                 //                     : x.pillarType == 'Light Post'
//                 //                         ? 'dot-violet-complete'
//                 //                         : x.pillarType == 'New Pole'
//                 //                             ? 'dot-orange-complete'
//                 //                             : x.pillarType == 'Telephone Pole'
//                 //                                 ? 'dot-blue-complete'
//                 //                                 : 'dot-black-complete')
//                 //             : x.workStatus == 'Aborted'
//                 //                 ? RenderSvg(
//                 //                     path: x.pillarType == 'Electricity Pole'
//                 //                         ? 'dot-red-aborted'
//                 //                         : x.pillarType == 'Light Post'
//                 //                             ? 'dot-violet-aborted'
//                 //                             : x.pillarType == 'New Pole'
//                 //                                 ? 'dot-orange-aborted'
//                 //                                 : x.pillarType == 'Telephone Pole'
//                 //                                     ? 'dot-blue-aborted'
//                 //                                     : 'dot-black-aborted')
//                 //                 : x.workStatus == 'Started' || x.workStatus == 'Restarted' || x.workStatus == 'WIP'
//                 //                     ? RenderSvg(
//                 //                         path: x.pillarType == 'Electricity Pole'
//                 //                             ? 'dot-red-wip-started-restarted'
//                 //                             : x.pillarType == 'Light Post'
//                 //                                 ? 'dot-violet-wip-started-restarted'
//                 //                                 : x.pillarType == 'New Pole'
//                 //                                     ? 'dot-orange-wip-started-restarted'
//                 //                                     : x.pillarType == 'Telephone Pole'
//                 //                                         ? 'dot-blue-wip-started-restarted'
//                 //                                         : 'dot-black-wip-started-restarted')
//                 //                     : RenderSvg(
//                 //                         height: 12,
//                 //                         path: x.pillarType == 'Electricity Pole'
//                 //                             ? 'electricity-pole'
//                 //                             : x.pillarType == 'Light Post'
//                 //                                 ? 'light-post'
//                 //                                 : x.pillarType == 'New Pole'
//                 //                                     ? 'new-pole'
//                 //                                     : x.pillarType == 'Telephone Pole'
//                 //                                         ? 'telephone-pole'
//                 //                                         : 'building')
//                 //         : Icon(
//                 //             Icons.location_on,
//                 //             color: x.functionType == 'Wifi Router' ? Colors.green : Colors.red,
//                 //             size: 40,
//                 //           ),
//                 //   );
//                 // }, markerId:MarkerId(x.id!) ,

//                 ),
//           );
//           // bounds.extend(LatLng(x.latitude!, x.longitude!));
//         });
//       }

//       // isLoading.value = false;
//       // kMapControllerSiteLocation.fitBounds(
//       //   bounds,
//       //   options: const FitBoundsOptions(
//       //     padding: EdgeInsets.all(30),
//       //   ),
//       // );
//     } on DioError catch (e) {
//      // kLog(e.message);
//     }
//   }
// }
