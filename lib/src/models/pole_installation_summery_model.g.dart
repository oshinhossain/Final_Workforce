// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pole_installation_summery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoleInstallationSummeryModel _$PoleInstallationSummeryModelFromJson(
        Map<String, dynamic> json) =>
    PoleInstallationSummeryModel(
      workStatus: (json['workStatus'] as List<dynamic>?)
          ?.map((e) => WorkStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSummary: (json['TotalSummary'] as List<dynamic>?)
          ?.map((e) => TotalSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PoleInstallationSummeryModelToJson(
        PoleInstallationSummeryModel instance) =>
    <String, dynamic>{
      'workStatus': instance.workStatus,
      'TotalSummary': instance.totalSummary,
    };

WorkStatus _$WorkStatusFromJson(Map<String, dynamic> json) => WorkStatus(
      count: json['count'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$WorkStatusToJson(WorkStatus instance) =>
    <String, dynamic>{
      'count': instance.count,
      'status': instance.status,
    };

TotalSummary _$TotalSummaryFromJson(Map<String, dynamic> json) => TotalSummary(
      completedToday: json['completedToday'] as String?,
      targetSites: json['targetSites'] as String?,
      totalCompleted: json['totalCompleted'] as String?,
    );

Map<String, dynamic> _$TotalSummaryToJson(TotalSummary instance) =>
    <String, dynamic>{
      'completedToday': instance.completedToday,
      'targetSites': instance.targetSites,
      'totalCompleted': instance.totalCompleted,
    };
