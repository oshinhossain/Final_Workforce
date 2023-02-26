import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:workforce/src/config/base.dart';

class OneSignalService extends GetxService with Base {
  @override
  void onInit() async {
    await OneSignal.shared
        .setAppId('3e5d1826-1db7-4a47-a668-94c8047b87b8'); //dev
    // await OneSignal.shared
    //     .setAppId('2504cf65-beea-4bad-a611-b9c2e16f03e7'); //Live
    //Live
    await OneSignal.shared.promptUserForPushNotificationPermission();

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // kLog(event.notification.jsonRepresentation());

      /// Display Notification, send null to not display
      final data = event.notification;

      final title = data.body;

      final url = Uri.parse('${data.launchUrl}');

      final destPage = url.queryParameters['destPage'];
      final transportOrderNo = url.queryParameters['transportOrderNo'];

      // kLog(destPage);
      // kLog(transportOrderNo);
      // kLog(title);
      notificationsC.add(destPage!, title!, transportOrderNo!);
      //// kLog(
      //     "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
    });
    // OneSignal.shared.setOnDidDisplayInAppMessageHandler((event) {
    //   /// Display Notification, send null to not display

    //  // kLog(
    //       "Notification received in foreground notification: \n${event.jsonRepresentation().replaceAll("\\n", "\n")}");
    // });

    // OneSignal.shared
    //     .setInAppMessageClickedHandler((OSInAppMessageAction action) {
    //  // kLog(
    //       "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}");
    // });
    // kLog('Onesignal init');
    super.onInit();
  }
}
