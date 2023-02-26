// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
//  

// import '../../firebase_options.dart';

// class FirebaseController extends GetxController {
//   Future<void> initFirebase() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );

//     // final messaging = FirebaseMessaging.instance;
//     // await messaging.setForegroundNotificationPresentationOptions(
//     //   alert: true, // Required to display a heads up notification
//     //   badge: true,
//     //   sound: true,
//     // );

//     // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     //   messaging.subscribeToTopic('global');
//     //   print('Got a message whilst in the foreground!');

//     //   print('Message data: ${message.data}');

//     //   if (message.notification != null) {
//     //     print('Message also contained a notification: ${message.notification}');
//     //   }
//     // });

//    // kLog('firebase initialized');
//   }
// }
