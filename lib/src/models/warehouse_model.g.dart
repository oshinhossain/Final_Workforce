// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareHouseModel _$WareHouseModelFromJson(Map<String, dynamic> json) =>
    WareHouseModel(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      managerFullname: json['managerFullname'] as String?,
      managerUsername: json['managerUsername'] as String?,
      managerEmail: json['managerEmail'] as String?,
      managerMobile: json['managerMobile'] as String?,
      whCode: json['whCode'] as String?,
      whName: json['whName'] as String?,
      whAddress: json['whAddress'] as String?,
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
      ownerFullname: json['ownerFullname'] as String?,
      ownerUsername: json['ownerUsername'] as String?,
      ownerEmail: json['ownerEmail'] as String?,
      ownerMobile: json['ownerMobile'] as String?,
      digest: json['digest'],
      masterViewModel: json['masterViewModel'],
    );

Map<String, dynamic> _$WareHouseModelToJson(WareHouseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'managerFullname': instance.managerFullname,
      'managerUsername': instance.managerUsername,
      'managerEmail': instance.managerEmail,
      'managerMobile': instance.managerMobile,
      'whCode': instance.whCode,
      'whName': instance.whName,
      'whAddress': instance.whAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'ownerFullname': instance.ownerFullname,
      'ownerUsername': instance.ownerUsername,
      'ownerEmail': instance.ownerEmail,
      'ownerMobile': instance.ownerMobile,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
    };
