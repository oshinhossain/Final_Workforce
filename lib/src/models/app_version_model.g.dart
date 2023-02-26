// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersion _$AppVersionFromJson(Map<String, dynamic> json) => AppVersion(
      id: json['id'] as String?,
      appCode: json['appCode'] as String?,
      appName: json['appName'] as String?,
      appVersion: json['appVersion'] as String?,
      appSettingsVersion: json['appSettingsVersion'] as int?,
      serverLocationVersion: json['serverLocationVersion'] as int?,
      projectVersion: json['projectVersion'] as int?,
      categoryVersion: json['categoryVersion'] as int?,
      subcategoryVersion: json['subcategoryVersion'] as int?,
      dropdownVersion: json['dropdownVersion'] as int?,
      noticeVersion: json['noticeVersion'] as int?,
      adVersion: json['adVersion'] as int?,
      roleVersion: json['roleVersion'] as int?,
      agencyVersion: json['agencyVersion'] as int?,
    );

Map<String, dynamic> _$AppVersionToJson(AppVersion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appCode': instance.appCode,
      'appName': instance.appName,
      'appVersion': instance.appVersion,
      'appSettingsVersion': instance.appSettingsVersion,
      'serverLocationVersion': instance.serverLocationVersion,
      'projectVersion': instance.projectVersion,
      'categoryVersion': instance.categoryVersion,
      'subcategoryVersion': instance.subcategoryVersion,
      'dropdownVersion': instance.dropdownVersion,
      'noticeVersion': instance.noticeVersion,
      'adVersion': instance.adVersion,
      'roleVersion': instance.roleVersion,
      'agencyVersion': instance.agencyVersion,
    };
