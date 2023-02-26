import 'package:json_annotation/json_annotation.dart';
part 'attendance_history_model.g.dart';

@JsonSerializable()
class AttendanceHistoryModel {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? officeTimeCode;
  String? officeTimeName;
  String? fullname;
  String? username;
  String? email;
  String? mobile;
  String? attDate;
  String? timeType;
  String? timeValueText;
  double? timeValue24;
  String? locationId;
  String? locationCode;
  String? locationName;
  double? locLatitude;
  double? locLongitude;
  String? locGeographyPoint;
  String? purpose;
  String? remarks;
  double? latitude;
  double? longitude;
  String? geographyPoint;
  double? effectiveHours;
  String? effectiveHoursText;
  String? inDate;
  bool? lateValue;
  int? numberOfEntry;
  bool? isAbsent;
  dynamic masterViewModel;


  AttendanceHistoryModel({  
    this.id, this.agencyId,  this.agencyCode,  this.agencyName,
  this.officeTimeCode,
  this.officeTimeName,
  this.fullname,
  this.username,
  this.email,
  this.mobile,
  this.attDate,
  this.timeType,
  this.timeValueText,
  this.timeValue24,
  this.locationId,
  this.locationCode,
  this.locationName,
  this.locLatitude,
  this.locLongitude,
  this.locGeographyPoint,
  this.purpose,
  this.remarks,
  this.latitude,
  this.longitude,
  this.geographyPoint,
  this.effectiveHours,
  this.effectiveHoursText,
  this.inDate,
  this.lateValue,
  this.numberOfEntry,
  this.isAbsent,
 this.masterViewModel,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceHistoryModelToJson(this);
}
