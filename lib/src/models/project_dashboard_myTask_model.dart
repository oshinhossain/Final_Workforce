import 'package:json_annotation/json_annotation.dart';
part 'project_dashboard_myTask_model.g.dart';

@JsonSerializable()
class ProjectdashboardmyTask {
  String? id;
  String? ownerFullname;
  String? ownerEmail;
  String? supportNo;
  String? supportName;
  String? supportDescr;
  String? supportType;
  double? outputTarget;
  String? outputDescr;
  String? scheduledEndDate;

  ProjectdashboardmyTask({
    this.id,
    this.ownerFullname,
    this.ownerEmail,
    this.supportNo,
    this.supportName,
    this.supportDescr,
    this.supportType,
    this.outputTarget,
    this.outputDescr,
    this.scheduledEndDate,
  });

  factory ProjectdashboardmyTask.fromJson(Map<String, dynamic> json) =>
      _$ProjectdashboardmyTaskFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectdashboardmyTaskToJson(this);
}
