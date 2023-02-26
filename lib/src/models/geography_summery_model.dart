// pole_installation_summery_model
import 'package:json_annotation/json_annotation.dart';

part 'geography_summery_model.g.dart';

@JsonSerializable()
class GeographyInstallationSummeryModel {
  List<StatusSummaries>? statusSummaries;
  // @JsonKey(name: 'TotalSummary')
  List<HeaderSummaries>? headerSummaries;

  GeographyInstallationSummeryModel({
    this.statusSummaries,
    this.headerSummaries,
  });

  factory GeographyInstallationSummeryModel.fromJson(
          Map<String, dynamic> json) =>
      _$GeographyInstallationSummeryModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GeographyInstallationSummeryModelToJson(this);
}

@JsonSerializable()
class StatusSummaries {
  int? count;
  String? status;
  String? statusCode;

  StatusSummaries({
    this.count,
    this.status,
    this.statusCode,
  });

  factory StatusSummaries.fromJson(Map<String, dynamic> json) =>
      _$StatusSummariesFromJson(json);
  Map<String, dynamic> toJson() => _$StatusSummariesToJson(this);
}

@JsonSerializable()
class HeaderSummaries {
  int? completedToday;
  int? totalCompleted;
  int? targetGeographies;

  HeaderSummaries({
    this.completedToday,
    this.targetGeographies,
    this.totalCompleted,
  });

  factory HeaderSummaries.fromJson(Map<String, dynamic> json) =>
      _$HeaderSummariesFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderSummariesToJson(this);
}
