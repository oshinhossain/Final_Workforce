import 'package:json_annotation/json_annotation.dart';
part 'scenario_groupdata_get_model.g.dart';

@JsonSerializable()
class ScenarioGroupGet {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? testTypeId;
  String? testTypeCode;
  String? testTypeName;
  String? scenarioCode;
  String? scenarioName;
  String? digest;
  String? masterViewModel;

  ScenarioGroupGet(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.testTypeId,
      this.testTypeCode,
      this.testTypeName,
      this.scenarioCode,
      this.scenarioName,
      this.digest,
      this.masterViewModel});

  factory ScenarioGroupGet.fromJson(Map<String, dynamic> json) =>
      _$ScenarioGroupGetFromJson(json);
  Map<String, dynamic> toJson() => _$ScenarioGroupGetToJson(this);
}
