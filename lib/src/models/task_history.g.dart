// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskHistory _$TaskHistoryFromJson(Map<String, dynamic> json) => TaskHistory(
      id: json['id'] as String?,
      projectId: json['projectId'] as String?,
      statusCode: json['statusCode'] as String?,
      bucketId: json['bucketId'] as String?,
      groupId: json['groupId'] as String?,
      status: json['status'] as String?,
      activityId: json['activityId'] as String?,
      supportId: json['supportId'] as String?,
      outputAchieved: (json['outputAchieved'] as num?)?.toDouble(),
      outputDescr: json['outputDescr'] as String?,
      outputDate: json['outputDate'] as String?,
      outputDatetime: json['outputDatetime'] as String?,
      outputProgress: (json['outputProgress'] as num?)?.toDouble(),
      outputRemarks: json['outputRemarks'] as String?,
    );

Map<String, dynamic> _$TaskHistoryToJson(TaskHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'bucketId': instance.bucketId,
      'groupId': instance.groupId,
      'activityId': instance.activityId,
      'supportId': instance.supportId,
      'outputAchieved': instance.outputAchieved,
      'outputDescr': instance.outputDescr,
      'outputDate': instance.outputDate,
      'outputDatetime': instance.outputDatetime,
      'outputProgress': instance.outputProgress,
      'outputRemarks': instance.outputRemarks,
      'statusCode': instance.statusCode,
      'status': instance.status,
    };
