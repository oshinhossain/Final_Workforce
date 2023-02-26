import 'package:hive/hive.dart';
part 'push_notifiaction_model.g.dart';

@HiveType(typeId: 5)
class PushNotificationModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? destPage;

  @HiveField(3)
  String? transportOrderNo;

  PushNotificationModel({
    this.id,
    this.title,
    this.destPage,
    this.transportOrderNo,
  });
}
