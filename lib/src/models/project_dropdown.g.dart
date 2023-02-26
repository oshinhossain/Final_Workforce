// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_dropdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDropdown _$ProjectDropdownFromJson(Map<String, dynamic> json) =>
    ProjectDropdown(
      id: json['id'] as String?,
      projectName: json['projectName'] as String?,
      projectCode: json['projectCode'] as String?,
      pmFullname: json['pmFullname'] as String?,
      pmUsername: json['pmUsername'] as String?,
      pmEmail: json['pmEmail'] as String?,
      pmMobile: json['pmMobile'] as String?,
    );

Map<String, dynamic> _$ProjectDropdownToJson(ProjectDropdown instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'projectCode': instance.projectCode,
      'pmFullname': instance.pmFullname,
      'pmUsername': instance.pmUsername,
      'pmEmail': instance.pmEmail,
      'pmMobile': instance.pmMobile,
    };
