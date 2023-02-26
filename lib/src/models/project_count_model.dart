import 'package:json_annotation/json_annotation.dart';
part 'project_count_model.g.dart';

@JsonSerializable()
class ProjectCount {
  String? tasks;
  String? milesstones;
  String? activities;
  String? buckets;
  String? groups;

  ProjectCount(
      {this.tasks,
      this.milesstones,
      this.activities,
      this.buckets,
      this.groups});

  factory ProjectCount.fromJson(Map<String, dynamic> json) =>
      _$ProjectCountFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectCountToJson(this);
}
