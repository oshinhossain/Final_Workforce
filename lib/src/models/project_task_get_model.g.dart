// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_task_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTaskGet _$ProjectTaskGetFromJson(Map<String, dynamic> json) =>
    ProjectTaskGet(
      id: json['id'] as String?,
      projectName: json['projectName'] as String?,
      bucketName: json['bucketName'] as String?,
      groupName: json['groupName'] as String?,
      activityName: json['activityName'] as String?,
      ownerFullname: json['ownerFullname'] as String?,
      ownerUsername: json['ownerUsername'] as String?,
      supportNo: json['supportNo'] as String?,
      supportName: json['supportName'] as String?,
      supportDescr: json['supportDescr'] as String?,
      supportType: json['supportType'] as String?,
      outputTarget: (json['outputTarget'] as num?)?.toDouble(),
      outputDescr: json['outputDescr'] as String?,
      outputAchieved: (json['outputAchieved'] as num?)?.toDouble(),
      outputProgress: (json['outputProgress'] as num?)?.toDouble(),
      assignedFullname: json['assignedFullname'] as String?,
      assignedUsername: json['assignedUsername'] as String?,
      scheduledStartDate: json['scheduledStartDate'] as String?,
      scheduledEndDate: json['scheduledEndDate'] as String?,
      status: json['status'] as String?,
      statusCode: json['statusCode'] as String?,
      remainingDays: json['remainingDays'] as int?,
      remainingQty: (json['remainingQty'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProjectTaskGetToJson(ProjectTaskGet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'bucketName': instance.bucketName,
      'groupName': instance.groupName,
      'activityName': instance.activityName,
      'ownerFullname': instance.ownerFullname,
      'ownerUsername': instance.ownerUsername,
      'supportNo': instance.supportNo,
      'supportName': instance.supportName,
      'supportDescr': instance.supportDescr,
      'supportType': instance.supportType,
      'outputTarget': instance.outputTarget,
      'outputDescr': instance.outputDescr,
      'outputAchieved': instance.outputAchieved,
      'outputProgress': instance.outputProgress,
      'assignedFullname': instance.assignedFullname,
      'assignedUsername': instance.assignedUsername,
      'scheduledStartDate': instance.scheduledStartDate,
      'scheduledEndDate': instance.scheduledEndDate,
      'status': instance.status,
      'statusCode': instance.statusCode,
      'remainingDays': instance.remainingDays,
      'remainingQty': instance.remainingQty,
    };
