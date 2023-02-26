// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_dashboard_myTask_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectdashboardmyTask _$ProjectdashboardmyTaskFromJson(
        Map<String, dynamic> json) =>
    ProjectdashboardmyTask(
      id: json['id'] as String?,
      ownerFullname: json['ownerFullname'] as String?,
      ownerEmail: json['ownerEmail'] as String?,
      supportNo: json['supportNo'] as String?,
      supportName: json['supportName'] as String?,
      supportDescr: json['supportDescr'] as String?,
      supportType: json['supportType'] as String?,
      outputTarget: (json['outputTarget'] as num?)?.toDouble(),
      outputDescr: json['outputDescr'] as String?,
      scheduledEndDate: json['scheduledEndDate'] as String?,
    );

Map<String, dynamic> _$ProjectdashboardmyTaskToJson(
        ProjectdashboardmyTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerFullname': instance.ownerFullname,
      'ownerEmail': instance.ownerEmail,
      'supportNo': instance.supportNo,
      'supportName': instance.supportName,
      'supportDescr': instance.supportDescr,
      'supportType': instance.supportType,
      'outputTarget': instance.outputTarget,
      'outputDescr': instance.outputDescr,
      'scheduledEndDate': instance.scheduledEndDate,
    };
