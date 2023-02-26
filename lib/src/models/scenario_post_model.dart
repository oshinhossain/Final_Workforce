import 'package:json_annotation/json_annotation.dart';

part 'scenario_post_model.g.dart';

@JsonSerializable()
class ScenarioPostModel {
  String? scenarioId;

  String? testResult;
  ScenarioPostModel({required this.scenarioId, required this.testResult});

  factory ScenarioPostModel.fromJson(Map<String, dynamic> json) =>
      _$ScenarioPostModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScenarioPostModelToJson(this);
}
