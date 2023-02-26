// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectDriverModel _$SelectDriverModelFromJson(Map<String, dynamic> json) =>
    SelectDriverModel(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      vehicleClass: json['vehicleClass'] as String?,
      licenseType: json['licenseType'] as String?,
      invitedOn: json['invitedOn'] as String?,
      preferredCity: json['preferredCity'] as String?,
      ridesKm: (json['ridesKm'] as num?)?.toDouble(),
      ridesCount: json['ridesCount'] as int?,
      preferredTimeFrom: json['preferredTimeFrom'] as String?,
      preferredTimeTo: json['preferredTimeTo'] as String?,
      userRating: (json['userRating'] as num?)?.toDouble(),
      isChecked: json['isChecked'] as bool?,
      selectedId: json['selectedId'] as String?,
    );

Map<String, dynamic> _$SelectDriverModelToJson(SelectDriverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'driverFullname': instance.driverFullname,
      'driverUsername': instance.driverUsername,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'vehicleClass': instance.vehicleClass,
      'licenseType': instance.licenseType,
      'invitedOn': instance.invitedOn,
      'preferredCity': instance.preferredCity,
      'ridesKm': instance.ridesKm,
      'ridesCount': instance.ridesCount,
      'preferredTimeFrom': instance.preferredTimeFrom,
      'preferredTimeTo': instance.preferredTimeTo,
      'userRating': instance.userRating,
      'isChecked': instance.isChecked,
      'selectedId': instance.selectedId,
    };
