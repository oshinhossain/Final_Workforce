import 'package:json_annotation/json_annotation.dart';

import 'scenario_post_model.dart';

part 'test_result_post_model.g.dart';

@JsonSerializable()
class TestResultPostModel {

        String? criterionId;
          String  ?remarks;
          bool ? testPassed;
          List<ScenarioPostModel> ? testResultScenarios;
          TestResultPostModel({required this.criterionId,required this.remarks,required this.testPassed,required this.testResultScenarios});

  factory TestResultPostModel.fromJson(Map<String, dynamic> json) =>
      _$TestResultPostModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestResultPostModelToJson(this);
}
