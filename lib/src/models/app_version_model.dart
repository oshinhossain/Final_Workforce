import 'package:json_annotation/json_annotation.dart';
part 'app_version_model.g.dart';

@JsonSerializable()
class AppVersion {
  String? id;
  String? appCode;
  String? appName;
  String? appVersion;
  int? appSettingsVersion;
  int? serverLocationVersion;
  int? projectVersion;
  int? categoryVersion;
  int? subcategoryVersion;
  int? dropdownVersion;
  int? noticeVersion;
  int? adVersion;
  int? roleVersion;
  int? agencyVersion;

  AppVersion(
      {this.id,
      this.appCode,
      this.appName,
      this.appVersion,
      this.appSettingsVersion,
      this.serverLocationVersion,
      this.projectVersion,
      this.categoryVersion,
      this.subcategoryVersion,
      this.dropdownVersion,
      this.noticeVersion,
      this.adVersion,
      this.roleVersion,
      this.agencyVersion});

  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionToJson(this);
}
