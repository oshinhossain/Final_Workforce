// import 'package:flutter_fcm/Notification/FCM.dart';
//  
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:workforce/src/helpers/route.dart';
// import 'package:workforce/src/pages/assign_vehicle_and_driver_page.dart';
// import 'package:workforce/src/pages/confirm_material_receipt_page.dart';
// import 'package:workforce/src/pages/confirm_recipient_page.dart';
// import 'package:workforce/src/pages/confirm_transport_page.dart';
// import 'package:workforce/src/pages/inspect_materials_to_drop_page.dart';
// import 'package:workforce/src/pages/inspect_materials_to_transport_page.dart';
// import 'package:workforce/src/pages/load_materials_vehicle_page.dart';
// import 'package:workforce/src/pages/start_journey_page.dart';
// import 'package:workforce/src/pages/unload_materials_vehicle_page.dart';

// class FcmService {
//   static String token = 'token';

//   static deleteToken() {
//     FCM.deleteRefreshToken();
//   }

//   static Future<void> onNotificationReceived(RemoteMessage message) async {
//     // offAll(CreateTransportOrderPreview());

//    // kLog(message.data['field6Value']);
//   }

//   static void initFCM() async {
//     try {
//      // kLog(FCM);
//       await FCM.initializeFCM(
//         withLocalNotification: true,

//         onNotificationReceived: onNotificationReceived,

//         onNotificationPressed: (Map<String, dynamic> data) {
//           final transportOrderNo = data['field1Name'] as String;

//           switch (data['field6Value']) {
//             case 'assign_vehicles_and_drivers':
//               offAll(AssignVehicleAndDriverPage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//             case 'inspect_materials_to_transport':
//               offAll(InspectMaterialsToTransportPage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;

//             case 'load_materials_to_vehicles':
//               offAll(LoadMaterialsVehiclePage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//             case 'confirm_transport_order_readiness_by_driver':
//               offAll(ConfirmTransportOrderReadinessByDriverPage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//             case 'confirm_transport_order_readiness_by_receiver':
//               offAll(ConfirmTransportOrderReadinessBYReceiverPage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//             case 'start_journey':
//               offAll(StartJourneyPage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//             case 'Unload_materials_from_vehicles':
//               offAll(UnloadMaterialsVehicle(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//             case 'confirm_material_receipt':
//               offAll(ConfirmMaterialReceiptPage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//             case 'inspect_materials_at_drop_locations':
//               offAll(InspectMaterialsToDropLocationPage(
//                 isFromNotification: true,
//                 transportOrderNo: transportOrderNo,
//               ));
//               break;
//           }
//         },
//         onTokenChanged: (String? token) {
//           FcmService.token = token!;
//           print(token);
//         },
//         // TODO add this icon to android/app/src/main/res/drawable/ic_launcher.png
//         icon: 'ic_launcher',
//       );

//      // kLog('FCM');
//     } catch (e) {
//       print(e);
//     }
//   }
// }
