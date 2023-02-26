// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project _planning_board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectPlanningBoard _$ProjectPlanningBoardFromJson(
        Map<String, dynamic> json) =>
    ProjectPlanningBoard(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      agencyId: json['agencyId'] as String?,
      countIssue: json['countIssue'] as int?,
      countRisk: json['countRisk'] as int?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      scheduledEndDate: json['scheduledEndDate'] as String?,
      outputTarget: (json['outputTarget'] as num?)?.toDouble(),
      outputDescr: json['outputDescr'] as String?,
      outputAchieved: (json['outputAchieved'] as num?)?.toDouble(),
      outputProgress: (json['outputProgress'] as num?)?.toDouble(),
      pmFullname: json['pmFullname'] as String?,
      pmUsername: json['pmUsername'] as String?,
      pmMobile: json['pmMobile'] as String?,
      countR: json['countR'] as int?,
      countA: json['countA'] as int?,
      countS: json['countS'] as int?,
      countC: json['countC'] as int?,
      countI: json['countI'] as int?,
      status: json['status'] as String?,
      projectDescr: json['projectDescr'] as String?,
    );

Map<String, dynamic> _$ProjectPlanningBoardToJson(
        ProjectPlanningBoard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'scheduledEndDate': instance.scheduledEndDate,
      'outputTarget': instance.outputTarget,
      'outputDescr': instance.outputDescr,
      'outputAchieved': instance.outputAchieved,
      'outputProgress': instance.outputProgress,
      'pmFullname': instance.pmFullname,
      'pmUsername': instance.pmUsername,
      'pmMobile': instance.pmMobile,
      'countR': instance.countR,
      'countA': instance.countA,
      'countS': instance.countS,
      'countC': instance.countC,
      'countI': instance.countI,
      'status': instance.status,
      'projectDescr': instance.projectDescr,
      'countRisk': instance.countRisk,
      'countIssue': instance.countIssue,
    };

ProjectCountGroup _$ProjectCountGroupFromJson(Map<String, dynamic> json) =>
    ProjectCountGroup(
      tasks: json['tasks'] as String?,
      milesstones: json['milesstones'] as String?,
      activities: json['activities'] as String?,
      buckets: json['buckets'] as String?,
      groups: json['groups'] as String?,
    );

Map<String, dynamic> _$ProjectCountGroupToJson(ProjectCountGroup instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
      'milesstones': instance.milesstones,
      'activities': instance.activities,
      'buckets': instance.buckets,
      'groups': instance.groups,
    };
