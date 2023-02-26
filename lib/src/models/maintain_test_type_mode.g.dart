// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintain_test_type_mode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintainTest _$MaintainTestFromJson(Map<String, dynamic> json) => MaintainTest(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      projectId: json['projectId'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      testTypeCode: json['testTypeCode'] as String?,
      testTypeName: json['testTypeName'] as String?,
      digest: json['digest'] as String?,
    );

Map<String, dynamic> _$MaintainTestToJson(MaintainTest instance) =>
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
      'testTypeCode': instance.testTypeCode,
      'testTypeName': instance.testTypeName,
      'digest': instance.digest,
    };
