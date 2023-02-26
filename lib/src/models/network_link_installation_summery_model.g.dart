// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_link_installation_summery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkLinkInstallationSummeryModel
    _$NetworkLinkInstallationSummeryModelFromJson(Map<String, dynamic> json) =>
        NetworkLinkInstallationSummeryModel(
          totalCoreSummary: json['totalCoreSummary'] == null
              ? null
              : TotalCoreSummary.fromJson(
                  json['totalCoreSummary'] as Map<String, dynamic>),
          dailyCoreSummary: json['dailyCoreSummary'] == null
              ? null
              : DailyCoreSummary.fromJson(
                  json['dailyCoreSummary'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$NetworkLinkInstallationSummeryModelToJson(
        NetworkLinkInstallationSummeryModel instance) =>
    <String, dynamic>{
      'totalCoreSummary': instance.totalCoreSummary,
      'dailyCoreSummary': instance.dailyCoreSummary,
    };

TotalCoreSummary _$TotalCoreSummaryFromJson(Map<String, dynamic> json) =>
    TotalCoreSummary(
      totalTarget: (json['totalTarget'] as num?)?.toDouble(),
      totalInstalled: (json['totalInstalled'] as num?)?.toDouble(),
      coreSummary: (json['coreSummary'] as List<dynamic>?)
          ?.map((e) => CoreSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TotalCoreSummaryToJson(TotalCoreSummary instance) =>
    <String, dynamic>{
      'totalTarget': instance.totalTarget,
      'totalInstalled': instance.totalInstalled,
      'coreSummary': instance.coreSummary,
    };

CoreSummary _$CoreSummaryFromJson(Map<String, dynamic> json) => CoreSummary(
      lengthkm: (json['lengthkm'] as num?)?.toDouble(),
      core: json['core'] as String?,
    );

Map<String, dynamic> _$CoreSummaryToJson(CoreSummary instance) =>
    <String, dynamic>{
      'lengthkm': instance.lengthkm,
      'core': instance.core,
    };

DailyCoreSummary _$DailyCoreSummaryFromJson(Map<String, dynamic> json) =>
    DailyCoreSummary(
      totalTarget: (json['totalTarget'] as num?)?.toDouble(),
      totalInstalled: (json['totalInstalled'] as num?)?.toDouble(),
      coreSummary: (json['coreSummary'] as List<dynamic>?)
          ?.map((e) => CoreSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyCoreSummaryToJson(DailyCoreSummary instance) =>
    <String, dynamic>{
      'totalTarget': instance.totalTarget,
      'totalInstalled': instance.totalInstalled,
      'coreSummary': instance.coreSummary,
    };
