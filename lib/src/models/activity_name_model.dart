import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity_name_model.g.dart';

@JsonSerializable()
class ActivityDropdown {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? bucketId;
  String? bucketCode;
  String? bucketName;
  String? groupCode;
  String? groupName;
  double? outputTarget;
  String? assignedFullname;
  String? assignedUsername;
  String? outputDescr;
  String? supportDescr;
  String? status;
  double? outputProgress;
  double? outputAchieved;
  double? weightPct;
  String? scheduledEndDate;
  String? assignedMobile;
  String? assignedEmail;

  List<Activities>? activities;

  ActivityDropdown({
    this.id,
    this.countryCode,
    this.countryName,
    this.outputProgress,
    this.agencyId,
    this.agencyCode,
    this.outputTarget,
    this.outputDescr,
    this.agencyName,
    this.projectId,
    this.projectCode,
    this.projectName,
    this.bucketId,
    this.assignedFullname,
    this.assignedUsername,
    this.bucketCode,
    this.bucketName,
    this.groupCode,
    this.groupName,
    this.activities,
    this.supportDescr,
    this.outputAchieved,
    this.weightPct,
    this.scheduledEndDate,
    this.assignedMobile,
    this.assignedEmail,
    this.status,
  });

  factory ActivityDropdown.fromJson(Map<String, dynamic> json) =>
      _$ActivityDropdownFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityDropdownToJson(this);
}

@JsonSerializable()
class Activities {
  String? id;
  String? countryCode;
  String? countryName;
  dynamic agencyId;
  dynamic agencyCode;
  dynamic agencyName;
  String? projectId;
  dynamic projectCode;
  String? projectName;
  String? bucketId;
  String? bucketCode;
  String? bucketName;
  String? groupId;
  String? groupCode;
  String? groupName;
  String? activityCode;
  String? activityName;
  dynamic activityDescr;
  dynamic prevActivityId;
  dynamic prevActivityCode;
  dynamic prevActivityName;
  int? childrenCount;
  String? milestoneCode;
  String? milestoneName;
  String? respAgencyId;
  String? respAgencyCode;
  String? respAgencyName;
  String? fullname;
  String? username;
  String? email;
  dynamic mobile;
  String? scheduledStartDate;
  String? scheduledEndDate;
  double? scheduledDuration;
  double? estimatedMandays;
  String? actualStartDate;
  String? actualEndDate;
  double? actualDuration;
  double? actualMandays;
  String? esDate;
  String? lsDate;
  String? efDate;
  String? lfDate;
  double? slackTime;
  double? outputTarget;
  String? outputDescr;
  double? outputTargetAssigned;
  double? outputAchieved;
  double? outputProgress;
  dynamic activityInput;
  dynamic activityCtq;
  int? countA;
  int? countS;
  int? countC;
  int? countI;
  double? progressR;
  double? progressA;
  double? progressS;
  double? progressC;
  double? progressI;
  double? progressSNotAccepted;
  double? progressCNotAccepted;

  bool? onCriticalPath;
  bool? outputPartOfProjectOutput;
  bool? testNeeded;
  bool? spreadOverGeography;
  String? status;
  double? weightPct;

  Activities(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.bucketId,
      this.bucketCode,
      this.bucketName,
      this.groupId,
      this.groupCode,
      this.groupName,
      this.activityCode,
      this.activityName,
      this.activityDescr,
      this.prevActivityId,
      this.prevActivityCode,
      this.prevActivityName,
      this.childrenCount,
      this.milestoneCode,
      this.milestoneName,
      this.respAgencyId,
      this.respAgencyCode,
      this.respAgencyName,
      this.fullname,
      this.username,
      this.email,
      this.mobile,
      this.scheduledStartDate,
      this.scheduledEndDate,
      this.scheduledDuration,
      this.estimatedMandays,
      this.actualStartDate,
      this.actualEndDate,
      this.actualDuration,
      this.actualMandays,
      this.esDate,
      this.lsDate,
      this.efDate,
      this.lfDate,
      this.slackTime,
      this.outputTarget,
      this.outputDescr,
      this.outputTargetAssigned,
      this.outputAchieved,
      this.outputProgress,
      this.activityInput,
      this.activityCtq,
      this.countA,
      this.countS,
      this.countC,
      this.countI,
      this.progressR,
      this.progressA,
      this.progressS,
      this.progressC,
      this.progressI,
      this.progressSNotAccepted,
      this.progressCNotAccepted,
      this.onCriticalPath,
      this.outputPartOfProjectOutput,
      this.testNeeded,
      this.spreadOverGeography,
      this.status,
      this.weightPct});

  factory Activities.fromJson(Map<String, dynamic> json) =>
      _$ActivitiesFromJson(json);
  Map<String, dynamic> toJson() => _$ActivitiesToJson(this);
}

// @JsonSerializable(constructor: '_')
// class A {
//   final int x;
//   A._(this.x);

//   factory A.fromJson(Map<String, dynamic> json) => _$AFromJson(json);
// }
//-----------//

//-----------//

// @JsonSerializable()
// class MyObject {
//   IconData? data;

//   String? name;

//   MyObject({this.name, this.data});

//   factory MyObject.fromJson(Map<String, dynamic> json) =>
//       _$MyObjectFromJson(json);
//   Map<String, dynamic> toJson() => _$MyObjectToJson(this);
// }
