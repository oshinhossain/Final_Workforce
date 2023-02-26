import 'package:json_annotation/json_annotation.dart';
part 'task_history.g.dart';

@JsonSerializable()
class TaskHistory {
  String? id;
  String? projectId;
  String? bucketId;
  String? groupId;
  String? activityId;
  String? supportId;
  double? outputAchieved;
  String? outputDescr;
  String? outputDate;
  String? outputDatetime;
  double? outputProgress;
  String? outputRemarks;
  String? statusCode;
  String ?status;

  TaskHistory(
      {this.id,
      this.projectId,
      this.statusCode,
      this.bucketId,
      this.groupId,this.status,
      this.activityId,
      this.supportId,
      this.outputAchieved,
      this.outputDescr,
      this.outputDate,
      this.outputDatetime,
      this.outputProgress,
      this.outputRemarks});

  factory TaskHistory.fromJson(Map<String, dynamic> json) =>
      _$TaskHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$TaskHistoryToJson(this);
}
