import 'package:hive/hive.dart';
import 'package:workforce/src/hive_models/attendance_history.dart';

part 'attendance.g.dart';

@HiveType(typeId: 2)
class Attendance {
  @HiveField(0)
  String? purpose;

  @HiveField(1)
  num? lat;

  @HiveField(2)
  num? long;

  @HiveField(3)
  int? effectiveHours;

  @HiveField(4)
  String? attendanceEventType;

  @HiveField(5)
  DateTime? firstInTime;

  @HiveField(6)
  DateTime? lastInTime;

  @HiveField(7)
  DateTime? lastOutTime;

  @HiveField(8)
  bool? isOfficeEnd;

  @HiveField(9)
  String? locationType;

  @HiveField(10)
  List<AttendanceHistory> history;

  @HiveField(11)
  DateTime? presentDay;

  Attendance({
    this.presentDay,
    this.locationType,
    this.purpose,
    this.attendanceEventType,
    this.effectiveHours,
    this.firstInTime,
    this.lat,
    this.long,
    this.isOfficeEnd,
    this.lastInTime,
   required this.history,
    this.lastOutTime,
  });
}
