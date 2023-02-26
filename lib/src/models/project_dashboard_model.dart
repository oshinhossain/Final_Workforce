import 'package:json_annotation/json_annotation.dart';
part 'project_dashboard_model.g.dart';

@JsonSerializable()
class ProjectDashbord {
  String? id;
  String? projectCode;
  String? projectName;
  String? projectDescr;
  double? outputProgress;
  String? icon;

  ProjectDashbord(
      {this.id,
      this.projectCode,
      this.projectName,
      this.projectDescr,
      this.outputProgress,
      this.icon});

  factory ProjectDashbord.fromJson(Map<String, dynamic> json) =>
      _$ProjectDashbordFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectDashbordToJson(this);
}
