import 'package:json_annotation/json_annotation.dart';
part 'task_detail.g.dart';

@JsonSerializable()
class TaskDetail {
  String? id;
  String? projectName;
  String? bucketName;
  String? groupName;
  String? activityName;
  String? ownerFullname;
  String? ownerUsername;
  String? supportNo;
  String? supportName;
  String? supportDescr;
  String? supportType;
  double? outputTarget;
  String? outputDescr;
  double? outputAchieved;
  double? outputProgress;
  String? assignedFullname;
  String? assignedUsername;
  String? scheduledStartDate;
  String? scheduledEndDate;
  String? status;
  String? statusCode;
  int? remainingDays;
  double? remainingQty;

  TaskDetail(
      {this.id,
      this.projectName,
      this.bucketName,
      this.statusCode,
      this.groupName,
      this.activityName,
      this.ownerFullname,
      this.ownerUsername,
      this.supportNo,
      this.supportName,
      this.supportDescr,
      this.supportType,
      this.outputTarget,
      this.outputDescr,
      this.outputAchieved,
      this.outputProgress,
      this.assignedFullname,
      this.assignedUsername,
      this.scheduledStartDate,
      this.scheduledEndDate,
      this.status,
      this.remainingDays,
      this.remainingQty});

  factory TaskDetail.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDetailToJson(this);
}
