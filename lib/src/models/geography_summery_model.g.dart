// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geography_summery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeographyInstallationSummeryModel _$GeographyInstallationSummeryModelFromJson(
        Map<String, dynamic> json) =>
    GeographyInstallationSummeryModel(
      statusSummaries: (json['statusSummaries'] as List<dynamic>?)
          ?.map((e) => StatusSummaries.fromJson(e as Map<String, dynamic>))
          .toList(),
      headerSummaries: (json['headerSummaries'] as List<dynamic>?)
          ?.map((e) => HeaderSummaries.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeographyInstallationSummeryModelToJson(
        GeographyInstallationSummeryModel instance) =>
    <String, dynamic>{
      'statusSummaries': instance.statusSummaries,
      'headerSummaries': instance.headerSummaries,
    };

StatusSummaries _$StatusSummariesFromJson(Map<String, dynamic> json) =>
    StatusSummaries(
      count: json['count'] as int?,
      status: json['status'] as String?,
      statusCode: json['statusCode'] as String?,
    );

Map<String, dynamic> _$StatusSummariesToJson(StatusSummaries instance) =>
    <String, dynamic>{
      'count': instance.count,
      'status': instance.status,
      'statusCode': instance.statusCode,
    };

HeaderSummaries _$HeaderSummariesFromJson(Map<String, dynamic> json) =>
    HeaderSummaries(
      completedToday: json['completedToday'] as int?,
      targetGeographies: json['targetGeographies'] as int?,
      totalCompleted: json['totalCompleted'] as int?,
    );

Map<String, dynamic> _$HeaderSummariesToJson(HeaderSummaries instance) =>
    <String, dynamic>{
      'completedToday': instance.completedToday,
      'totalCompleted': instance.totalCompleted,
      'targetGeographies': instance.targetGeographies,
    };
