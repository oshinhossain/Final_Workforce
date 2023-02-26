// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_user_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestSearchModel _$TestSearchModelFromJson(Map<String, dynamic> json) =>
    TestSearchModel(
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
      testNo: json['testNo'] as String?,
      testDate: json['testDate'] as String?,
      testerAgencyId: json['testerAgencyId'] as String?,
      testerAgencyCode: json['testerAgencyCode'] as String?,
      testerAgencyName: json['testerAgencyName'] as String?,
      testerFullname: json['testerFullname'] as String?,
      testerUsername: json['testerUsername'] as String?,
      testerEmail: json['testerEmail'] as String?,
      testerMobile: json['testerMobile'] as String?,
      digest: json['digest'] as String?,
      masterViewModel: json['masterViewModel'],
    );

Map<String, dynamic> _$TestSearchModelToJson(TestSearchModel instance) =>
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
      'testNo': instance.testNo,
      'testDate': instance.testDate,
      'testerAgencyId': instance.testerAgencyId,
      'testerAgencyCode': instance.testerAgencyCode,
      'testerAgencyName': instance.testerAgencyName,
      'testerFullname': instance.testerFullname,
      'testerUsername': instance.testerUsername,
      'testerEmail': instance.testerEmail,
      'testerMobile': instance.testerMobile,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
    };
