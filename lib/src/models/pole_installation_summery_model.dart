// pole_installation_summery_model
import 'package:json_annotation/json_annotation.dart';

part 'pole_installation_summery_model.g.dart';

@JsonSerializable()
class PoleInstallationSummeryModel {
  List<WorkStatus>? workStatus;
  @JsonKey(name: 'TotalSummary')
  List<TotalSummary>? totalSummary;

  PoleInstallationSummeryModel({
    this.workStatus,
    this.totalSummary,
  });

  factory PoleInstallationSummeryModel.fromJson(Map<String, dynamic> json) =>
      _$PoleInstallationSummeryModelFromJson(json);
  Map<String, dynamic> toJson() => _$PoleInstallationSummeryModelToJson(this);
}

@JsonSerializable()
class WorkStatus {
  String? count;
  String? status;

  WorkStatus({
    this.count,
    this.status,
  });

  factory WorkStatus.fromJson(Map<String, dynamic> json) =>
      _$WorkStatusFromJson(json);
  Map<String, dynamic> toJson() => _$WorkStatusToJson(this);
}

@JsonSerializable()
class TotalSummary {
  String? completedToday;
  String? targetSites;
  String? totalCompleted;

  TotalSummary({
    this.completedToday,
    this.targetSites,
    this.totalCompleted,
  });

  factory TotalSummary.fromJson(Map<String, dynamic> json) =>
      _$TotalSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$TotalSummaryToJson(this);
}
