import 'package:hive/hive.dart';

part 'attendance_history.g.dart';

@HiveType(typeId: 3)
class AttendanceHistory {
  @HiveField(0)
  String? eventType;

  @HiveField(1)
  String? time;

  @HiveField(2)
  String? location;

  @HiveField(3)
  String? purpose;

  @HiveField(4)
  String? remarks;

  @HiveField(5)
  int? lastEffectime;
  @HiveField(6)
  bool isFirst;
  @HiveField(7)
  int? lastEffectime1;

  AttendanceHistory(
      {this.eventType,
      this.location,
      this.purpose,
      this.remarks,
      this.time,
      this.lastEffectime,
      this.isFirst = false,
      this.lastEffectime1});
}
