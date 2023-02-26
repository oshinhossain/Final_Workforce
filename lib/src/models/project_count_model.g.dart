// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectCount _$ProjectCountFromJson(Map<String, dynamic> json) => ProjectCount(
      tasks: json['tasks'] as String?,
      milesstones: json['milesstones'] as String?,
      activities: json['activities'] as String?,
      buckets: json['buckets'] as String?,
      groups: json['groups'] as String?,
    );

Map<String, dynamic> _$ProjectCountToJson(ProjectCount instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
      'milesstones': instance.milesstones,
      'activities': instance.activities,
      'buckets': instance.buckets,
      'groups': instance.groups,
    };
