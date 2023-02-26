// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
      id: json['id'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
    );

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'projectCode': instance.projectCode,
    };
