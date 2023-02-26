// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_location_planning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialLocationPlanning _$MaterialLocationPlanningFromJson(
        Map<String, dynamic> json) =>
    MaterialLocationPlanning(
      id: json['id'] as String?,
      dropLocationCount: json['dropLocationCount'] as int?,
      geoLevel4Name: json['geoLevel4Name'] as String?,
      levelFullcode: json['levelFullcode'] as String?,
      dropLocTitle: json['dropLocTitle'] as String?,
      dropLocName: json['dropLocName'] as String?,
      projectCode: json['projectCode'] as String?,
      geograpphy: (json['geograpphy'] as List<dynamic>?)
          ?.map((e) => Geograpphy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaterialLocationPlanningToJson(
        MaterialLocationPlanning instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dropLocationCount': instance.dropLocationCount,
      'geoLevel4Name': instance.geoLevel4Name,
      'levelFullcode': instance.levelFullcode,
      'dropLocTitle': instance.dropLocTitle,
      'dropLocName': instance.dropLocName,
      'projectCode': instance.projectCode,
      'geograpphy': instance.geograpphy,
    };
