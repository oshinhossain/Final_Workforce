// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_relocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteRelocation _$SiteRelocationFromJson(Map<String, dynamic> json) =>
    SiteRelocation(
      siteId: json['siteId'] as String?,
      newLat: (json['newLat'] as num?)?.toDouble(),
      newLong: (json['newLong'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SiteRelocationToJson(SiteRelocation instance) =>
    <String, dynamic>{
      'siteId': instance.siteId,
      'newLat': instance.newLat,
      'newLong': instance.newLong,
    };
