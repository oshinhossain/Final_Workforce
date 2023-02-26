// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_delivery_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialDeliveryLoc _$MaterialDeliveryLocFromJson(Map<String, dynamic> json) =>
    MaterialDeliveryLoc(
      id: json['id'] as String?,
      dropLocationCount: json['dropLocationCount'] as int?,
      geoLevel4Name: json['geoLevel4Name'] as String?,
      levelFullcode: json['levelFullcode'] as String?,
      dropLocTitle: json['dropLocTitle'] as String?,
      dropLocName: json['dropLocName'] as String?,
      projectCode: json['projectCode'] as String?,
    );

Map<String, dynamic> _$MaterialDeliveryLocToJson(
        MaterialDeliveryLoc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dropLocationCount': instance.dropLocationCount,
      'geoLevel4Name': instance.geoLevel4Name,
      'levelFullcode': instance.levelFullcode,
      'dropLocTitle': instance.dropLocTitle,
      'dropLocName': instance.dropLocName,
      'projectCode': instance.projectCode,
    };
