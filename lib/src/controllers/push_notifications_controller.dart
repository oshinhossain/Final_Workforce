import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workforce/src/helpers/uniqe_id.dart';
import 'package:workforce/src/models/push_notifiaction_model.dart';

class PushNotificationsController extends GetxController {
  final notifications = RxList<PushNotificationModel>();

  void add(String destPage, String title, String transportOrderNo) async {
    final box = Hive.box<PushNotificationModel>('push_notifications');

    final id = getUniqeId();
    final pushNotificationData = PushNotificationModel(
      destPage: destPage,
      id: id,
      title: title,
      transportOrderNo: transportOrderNo,
    );

    await box.put(id, pushNotificationData);
    notifications.add(pushNotificationData);
  }

  Future<void> getNotifications() async {
    final box = Hive.box<PushNotificationModel>('push_notifications');

    final data = box.values.toList();
    if (data.isNotEmpty) {
      notifications.addAll(data);
    }
  }
}
