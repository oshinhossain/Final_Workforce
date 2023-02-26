import 'package:json_annotation/json_annotation.dart';
part 'post_task.g.dart';

@JsonSerializable()
class PostTask {
  String? id;
  String? projectName;
  String? bucketName;
  String? groupName;
  String? activityName;
  String? supportNo;
  String? supportName;
  String? supportType;
  double? outputProgress;
  String? status;
  String ?assignedUsername;
  int? remainingDays;

  PostTask({
    this.id,this.assignedUsername,
    this.projectName,
    this.bucketName,
    this.groupName,
    this.activityName,
    this.supportNo,
    this.supportName,
    this.supportType,
    this.outputProgress,
    this.status,
    this.remainingDays,
  });

  factory PostTask.fromJson(Map<String, dynamic> json) =>
      _$PostTaskFromJson(json);
  Map<String, dynamic> toJson() => _$PostTaskToJson(this);
}
