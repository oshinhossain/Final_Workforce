// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_driver_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyDriverModel _$AgencyDriverModelFromJson(Map<String, dynamic> json) =>
    AgencyDriverModel(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      inviterFullname: json['inviterFullname'] as String?,
      inviterUsername: json['inviterUsername'] as String?,
      inviterEmail: json['inviterEmail'] as String?,
      inviterMobile: json['inviterMobile'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      invitedOn: json['invitedOn'] as String?,
      acceptedOn: json['acceptedOn'] as String?,
      status: json['status'] as String?,
      digest: json['digest'] as String?,
      preferredCity: json['preferredCity'] as String?,
      ridesKm: (json['ridesKm'] as num?)?.toDouble(),
      ridesCount: json['ridesCount'] as int?,
      preferredTimeFrom: json['preferredTimeFrom'] as String?,
      preferredTimeTo: json['preferredTimeTo'] as String?,
      userRating: (json['userRating'] as num?)?.toDouble(),
      licenseType: json['licenseType'] as String?,
      statusCode: json['statusCode'] as String?,
      vehicleClass: json['vehicleClass'] as String?,
    );

Map<String, dynamic> _$AgencyDriverModelToJson(AgencyDriverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'inviterFullname': instance.inviterFullname,
      'inviterUsername': instance.inviterUsername,
      'inviterEmail': instance.inviterEmail,
      'inviterMobile': instance.inviterMobile,
      'driverFullname': instance.driverFullname,
      'driverUsername': instance.driverUsername,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'invitedOn': instance.invitedOn,
      'acceptedOn': instance.acceptedOn,
      'status': instance.status,
      'digest': instance.digest,
      'preferredCity': instance.preferredCity,
      'ridesKm': instance.ridesKm,
      'ridesCount': instance.ridesCount,
      'preferredTimeFrom': instance.preferredTimeFrom,
      'preferredTimeTo': instance.preferredTimeTo,
      'userRating': instance.userRating,
      'licenseType': instance.licenseType,
      'statusCode': instance.statusCode,
      'vehicleClass': instance.vehicleClass,
    };
