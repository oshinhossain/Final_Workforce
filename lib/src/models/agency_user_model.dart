import 'package:json_annotation/json_annotation.dart';

part 'agency_user_model.g.dart';

@JsonSerializable()
class AgencyUserModel {
  String? empId;
  String? userId;
  String? username;
  String? fullname;
  String? email;
  String? mobile;
  String? gender;
  String? reportingManagerUsername;
  String? reportingManagerFullname;
  String? reportingManagerEmail;
  String? reportingManagerMobile;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  dynamic countryId;
  dynamic countryCode;
  String? countryName;
  num? latitude;
  num? longitude;
  dynamic currentLocationUpdatedOn;
  dynamic currentLocationUpdatedAt;
  AgencyRoleModel? roleModel;
  dynamic myTeam;

  AgencyUserModel(
      {this.empId,
      this.userId,
      this.username,
      this.fullname,
      this.email,
      this.mobile,
      this.gender,
      this.reportingManagerUsername,
      this.reportingManagerFullname,
      this.reportingManagerEmail,
      this.reportingManagerMobile,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.countryId,
      this.countryCode,
      this.countryName,
      this.latitude,
      this.longitude,
      this.currentLocationUpdatedOn,
      this.currentLocationUpdatedAt,
      this.roleModel,
      this.myTeam});

  factory AgencyUserModel.fromJson(Map<String, dynamic> json) =>
      _$AgencyUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyUserModelToJson(this);
}

@JsonSerializable()
class AgencyRoleModel {
  String? roleGroup;
  int? roleGroupLevel;
  int? roleLevel;
  String? roleName;
  String? appCode;

  AgencyRoleModel(
      {this.roleGroup,
      this.roleGroupLevel,
      this.roleLevel,
      this.roleName,
      this.appCode});

  factory AgencyRoleModel.fromJson(Map<String, dynamic> json) =>
      _$AgencyRoleModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyRoleModelToJson(this);
}
