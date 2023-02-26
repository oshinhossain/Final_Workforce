// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenario_groupdata_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScenarioGroupGet _$ScenarioGroupGetFromJson(Map<String, dynamic> json) =>
    ScenarioGroupGet(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      projectId: json['projectId'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      testTypeId: json['testTypeId'] as String?,
      testTypeCode: json['testTypeCode'] as String?,
      testTypeName: json['testTypeName'] as String?,
      scenarioCode: json['scenarioCode'] as String?,
      scenarioName: json['scenarioName'] as String?,
      digest: json['digest'] as String?,
      masterViewModel: json['masterViewModel'] as String?,
    );

Map<String, dynamic> _$ScenarioGroupGetToJson(ScenarioGroupGet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'projectId': instance.projectId,
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'testTypeId': instance.testTypeId,
      'testTypeCode': instance.testTypeCode,
      'testTypeName': instance.testTypeName,
      'scenarioCode': instance.scenarioCode,
      'scenarioName': instance.scenarioName,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
    };
