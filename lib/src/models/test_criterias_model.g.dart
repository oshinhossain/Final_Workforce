// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_criterias_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestCriteriasGet _$TestCriteriasGetFromJson(Map<String, dynamic> json) =>
    TestCriteriasGet(
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
      groupId: json['groupId'] as String?,
      groupCode: json['groupCode'] as String?,
      groupName: json['groupName'] as String?,
      criterionCode: json['criterionCode'] as String?,
      criterionName: json['criterionName'] as String?,
      expectedResult: json['expectedResult'] as String?,
      digest: json['digest'] as String?,
      masterViewModel: json['masterViewModel'] as String?,
    );

Map<String, dynamic> _$TestCriteriasGetToJson(TestCriteriasGet instance) =>
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
      'groupId': instance.groupId,
      'groupCode': instance.groupCode,
      'groupName': instance.groupName,
      'criterionCode': instance.criterionCode,
      'criterionName': instance.criterionName,
      'expectedResult': instance.expectedResult,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
    };
