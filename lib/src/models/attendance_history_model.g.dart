// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceHistoryModel _$AttendanceHistoryModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceHistoryModel(
      id: json['id'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      officeTimeCode: json['officeTimeCode'] as String?,
      officeTimeName: json['officeTimeName'] as String?,
      fullname: json['fullname'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      attDate: json['attDate'] as String?,
      timeType: json['timeType'] as String?,
      timeValueText: json['timeValueText'] as String?,
      timeValue24: (json['timeValue24'] as num?)?.toDouble(),
      locationId: json['locationId'] as String?,
      locationCode: json['locationCode'] as String?,
      locationName: json['locationName'] as String?,
      locLatitude: (json['locLatitude'] as num?)?.toDouble(),
      locLongitude: (json['locLongitude'] as num?)?.toDouble(),
      locGeographyPoint: json['locGeographyPoint'] as String?,
      purpose: json['purpose'] as String?,
      remarks: json['remarks'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      geographyPoint: json['geographyPoint'] as String?,
      effectiveHours: (json['effectiveHours'] as num?)?.toDouble(),
      effectiveHoursText: json['effectiveHoursText'] as String?,
      inDate: json['inDate'] as String?,
      lateValue: json['lateValue'] as bool?,
      numberOfEntry: json['numberOfEntry'] as int?,
      isAbsent: json['isAbsent'] as bool?,
      masterViewModel: json['masterViewModel'],
    );

Map<String, dynamic> _$AttendanceHistoryModelToJson(
        AttendanceHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'officeTimeCode': instance.officeTimeCode,
      'officeTimeName': instance.officeTimeName,
      'fullname': instance.fullname,
      'username': instance.username,
      'email': instance.email,
      'mobile': instance.mobile,
      'attDate': instance.attDate,
      'timeType': instance.timeType,
      'timeValueText': instance.timeValueText,
      'timeValue24': instance.timeValue24,
      'locationId': instance.locationId,
      'locationCode': instance.locationCode,
      'locationName': instance.locationName,
      'locLatitude': instance.locLatitude,
      'locLongitude': instance.locLongitude,
      'locGeographyPoint': instance.locGeographyPoint,
      'purpose': instance.purpose,
      'remarks': instance.remarks,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'geographyPoint': instance.geographyPoint,
      'effectiveHours': instance.effectiveHours,
      'effectiveHoursText': instance.effectiveHoursText,
      'inDate': instance.inDate,
      'lateValue': instance.lateValue,
      'numberOfEntry': instance.numberOfEntry,
      'isAbsent': instance.isAbsent,
      'masterViewModel': instance.masterViewModel,
    };
