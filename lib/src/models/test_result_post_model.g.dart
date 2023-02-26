// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResultPostModel _$TestResultPostModelFromJson(Map<String, dynamic> json) =>
    TestResultPostModel(
      criterionId: json['criterionId'] as String?,
      remarks: json['remarks'] as String?,
      testPassed: json['testPassed'] as bool?,
      testResultScenarios: (json['testResultScenarios'] as List<dynamic>?)
          ?.map((e) => ScenarioPostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestResultPostModelToJson(
        TestResultPostModel instance) =>
    <String, dynamic>{
      'criterionId': instance.criterionId,
      'remarks': instance.remarks,
      'testPassed': instance.testPassed,
      'testResultScenarios': instance.testResultScenarios,
    };
