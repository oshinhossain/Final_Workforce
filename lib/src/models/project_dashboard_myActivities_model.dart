import 'package:json_annotation/json_annotation.dart';
part 'project_dashboard_myActivities_model.g.dart';

@JsonSerializable()
class ProjectdashboardmyActivities {
  String? id;
  String? projectCode;
  String? projectName;
  String? bucketCode;
  String? bucketName;
  String? groupCode;
  String? groupName;
  String? activityCode;
  String? activityName;
  String? fullname;
  String? email;
  String? scheduledEndDate;

  ProjectdashboardmyActivities(
      {this.id,
      this.projectCode,
      this.projectName,
      this.bucketCode,
      this.bucketName,
      this.groupCode,
      this.groupName,
      this.activityCode,
      this.activityName,
      this.fullname,
      this.email,
      this.scheduledEndDate});

  factory ProjectdashboardmyActivities.fromJson(Map<String, dynamic> json) =>
      _$ProjectdashboardmyActivitiesFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectdashboardmyActivitiesToJson(this);
}
