import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel {
  String? id;
  String? projectName;
  String? projectCode;

  ProjectModel({
    this.id,
    this.projectCode,
    this.projectName,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}
