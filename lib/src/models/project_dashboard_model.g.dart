// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDashbord _$ProjectDashbordFromJson(Map<String, dynamic> json) =>
    ProjectDashbord(
      id: json['id'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      projectDescr: json['projectDescr'] as String?,
      outputProgress: (json['outputProgress'] as num?)?.toDouble(),
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$ProjectDashbordToJson(ProjectDashbord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'projectDescr': instance.projectDescr,
      'outputProgress': instance.outputProgress,
      'icon': instance.icon,
    };
