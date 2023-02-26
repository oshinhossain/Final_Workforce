import 'package:json_annotation/json_annotation.dart';
part 'project_scope_bucket_board_model.g.dart';

@JsonSerializable()
class ProjectScopeBucketBoard {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? bucketCode;
  String? bucketName;
  double? outputTarget;
  String? outputDescr;
  double? outputTargetAssigned;
  double? outputAchieved;
  double? outputProgress;
  int? countR;
  int? countA;
  int? countS;
  int? countC;
  int? countI;
  double? progressR;
  double? progressA;
  double? progressS;
  double? progressC;
  double? progressI;
  String? fullname;
  String? username;
  String? email;
  String? mobile;
  String? digest;
  String? status;
  String? scheduledStartDate;
  String? scheduledEndDate;
  String? actualStartDate;
  String? bucketDescr;
  double? weightPct;

  ProjectScopeBucketBoard(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.bucketCode,
      this.bucketName,
      this.outputTarget,
      this.outputDescr,
      this.outputTargetAssigned,
      this.outputAchieved,
      this.outputProgress,
      this.countR,
      this.countA,
      this.countS,
      this.countC,
      this.countI,
      this.progressR,
      this.progressA,
      this.progressS,
      this.progressC,
      this.progressI,
      this.fullname,
      this.username,
      this.email,
      this.mobile,
      this.digest,
      this.actualStartDate,
      this.bucketDescr,
      this.scheduledEndDate,
      this.scheduledStartDate,
      this.status,
      this.weightPct});

  factory ProjectScopeBucketBoard.fromJson(Map<String, dynamic> json) =>
      _$ProjectScopeBucketBoardFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectScopeBucketBoardToJson(this);
}
