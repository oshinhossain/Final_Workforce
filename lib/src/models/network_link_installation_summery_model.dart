// pole_installation_summery_model
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_link_installation_summery_model.g.dart';

@JsonSerializable()
class NetworkLinkInstallationSummeryModel {
  // List<TotalCoreSummary>? totalCoreSummary;
  // dynamic dailyCoreSummary;

  TotalCoreSummary? totalCoreSummary;
  DailyCoreSummary? dailyCoreSummary;

  NetworkLinkInstallationSummeryModel(
      {
      // this.totalCoreSummary,
      // this.dailyCoreSummary,
      this.totalCoreSummary,
      this.dailyCoreSummary});

  factory NetworkLinkInstallationSummeryModel.fromJson(
          Map<String, dynamic> json) =>
      _$NetworkLinkInstallationSummeryModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$NetworkLinkInstallationSummeryModelToJson(this);
}

@JsonSerializable()
class TotalCoreSummary {
  double? totalTarget;
  double? totalInstalled;
  List<CoreSummary>? coreSummary;

  TotalCoreSummary({this.totalTarget, this.totalInstalled, this.coreSummary});

  factory TotalCoreSummary.fromJson(Map<String, dynamic> json) =>
      _$TotalCoreSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$TotalCoreSummaryToJson(this);
}

@JsonSerializable()
class CoreSummary {
  double? lengthkm;
  String? core;

  CoreSummary({this.lengthkm, this.core});

  factory CoreSummary.fromJson(Map<String, dynamic> json) =>
      _$CoreSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$CoreSummaryToJson(this);
}

@JsonSerializable()
class DailyCoreSummary {
  double? totalTarget;
  double? totalInstalled;
  List<CoreSummary>? coreSummary;

  DailyCoreSummary({this.totalTarget, this.totalInstalled, this.coreSummary});

  factory DailyCoreSummary.fromJson(Map<String, dynamic> json) =>
      _$DailyCoreSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$DailyCoreSummaryToJson(this);

  map(Column Function(dynamic e) param0) {}
}
