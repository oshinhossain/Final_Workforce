// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTask _$PostTaskFromJson(Map<String, dynamic> json) => PostTask(
      id: json['id'] as String?,
      assignedUsername: json['assignedUsername'] as String?,
      projectName: json['projectName'] as String?,
      bucketName: json['bucketName'] as String?,
      groupName: json['groupName'] as String?,
      activityName: json['activityName'] as String?,
      supportNo: json['supportNo'] as String?,
      supportName: json['supportName'] as String?,
      supportType: json['supportType'] as String?,
      outputProgress: (json['outputProgress'] as num?)?.toDouble(),
      status: json['status'] as String?,
      remainingDays: json['remainingDays'] as int?,
    );

Map<String, dynamic> _$PostTaskToJson(PostTask instance) => <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'bucketName': instance.bucketName,
      'groupName': instance.groupName,
      'activityName': instance.activityName,
      'supportNo': instance.supportNo,
      'supportName': instance.supportName,
      'supportType': instance.supportType,
      'outputProgress': instance.outputProgress,
      'status': instance.status,
      'assignedUsername': instance.assignedUsername,
      'remainingDays': instance.remainingDays,
    };
