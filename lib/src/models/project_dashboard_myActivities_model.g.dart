// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_dashboard_myActivities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectdashboardmyActivities _$ProjectdashboardmyActivitiesFromJson(
        Map<String, dynamic> json) =>
    ProjectdashboardmyActivities(
      id: json['id'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      bucketCode: json['bucketCode'] as String?,
      bucketName: json['bucketName'] as String?,
      groupCode: json['groupCode'] as String?,
      groupName: json['groupName'] as String?,
      activityCode: json['activityCode'] as String?,
      activityName: json['activityName'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      scheduledEndDate: json['scheduledEndDate'] as String?,
    );

Map<String, dynamic> _$ProjectdashboardmyActivitiesToJson(
        ProjectdashboardmyActivities instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'bucketCode': instance.bucketCode,
      'bucketName': instance.bucketName,
      'groupCode': instance.groupCode,
      'groupName': instance.groupName,
      'activityCode': instance.activityCode,
      'activityName': instance.activityName,
      'fullname': instance.fullname,
      'email': instance.email,
      'scheduledEndDate': instance.scheduledEndDate,
    };
