// import 'dart:isolate';

// import 'package:flutter_foreground_task_native/flutter_foreground_task_native.dart';
// import 'package:get/get.dart';

// class BackgroundTaskService extends GetxService {
//   @override
//   void onInit() async {
//     super.onInit();
//     await FlutterForegroundTask.init(
//       androidNotificationOptions: AndroidNotificationOptions(
//         channelId: 'workforce',
//         channelName: 'workforce',
//         channelDescription:
//             'This notification appears when the foreground service is running.',
//         channelImportance: NotificationChannelImportance.HIGH,
//         priority: NotificationPriority.HIGH,
//         enableVibration: true,
//         isSticky: true,
//         playSound: true,
//         visibility: NotificationVisibility.VISIBILITY_PUBLIC,
//         iconData: NotificationIconData(
//           resType: ResourceType.mipmap,
//           resPrefix: ResourcePrefix.ic,
//           name: 'ic_launcher',
//         ),
//         buttons: [
//           NotificationButton(id: 'sendButton', text: 'Send'),
//           NotificationButton(id: 'testButton', text: 'Test'),
//         ],
//       ),
//       foregroundTaskOptions:   ForegroundTaskOptions(
//         interval: 5000,
//         autoRunOnBoot: true,
//         allowWifiLock: true,
//       ),
//       printDevLog: true,
//     );

//     print('FlutterForegroundTask initialized');
//   }

//   // The callback function should always be a top-level function.
//   void startCallback() {
//     // The setTaskHandler function must be called to handle the task in the background.
//     FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
//   }

//   Future<bool> startForegroundTask() async {
//     ReceivePort? _receivePort;

//     // You can save data using the saveData function.
//     // await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

//     ReceivePort? receivePort;
//     if (await FlutterForegroundTask.isRunningService) {
//       receivePort = await FlutterForegroundTask.restartService();
//     } else {
//       receivePort = await FlutterForegroundTask.startService(
//         notificationTitle: 'Foreground Service is running',
//         notificationText: 'Tap to return to the app',
//         callback: startCallback,
//       );
//     }

//     if (receivePort != null) {
//       _receivePort = receivePort;
//       _receivePort.listen((message) {
//         if (message is DateTime) {
//           print('receive timestamp: $message');
//         }
//       });

//       return true;
//     }

//     return false;
//   }
// }

// class FirstTaskHandler extends TaskHandler {
//   @override
//   Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
//     // You can use the getData function to get the data you saved.
//     final customData =
//         await FlutterForegroundTask.getData<String>(key: 'customData');
//     print('customData: $customData');
//   }

//   @override
//   Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
//     // Send data to the main isolate.
//     sendPort?.send(timestamp);
//   }

//   @override
//   Future<void> onDestroy(DateTime timestamp) async {
//     // You can use the clearAllData function to clear all the stored data.
//     await FlutterForegroundTask.clearAllData();
//   }

//   @override
//   void onButtonPressed(String id) {
//     // Called when the notification button on the Android platform is pressed.
//     print('onButtonPressed >> $id');
//   }
// }
