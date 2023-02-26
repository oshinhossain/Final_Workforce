import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  dynamic id;
  dynamic countryId;
  dynamic countryCode;
  dynamic countryName;
  dynamic agencyId;
  dynamic agencyCode;
  dynamic agencyName;
  dynamic unitId;
  dynamic unitCode;
  dynamic unitName;
  dynamic locationId;
  dynamic locationCode;
  dynamic locationName;
  dynamic address;
  String? userId;
  String? username;
  String? fullname;
  dynamic phone;
  String? mobile;
  String? email;
  String? gender;
  num? officeLatitude;
  num? officeLongitude;
  dynamic reportingManagerId;
  dynamic reportingManagerUsername;
  dynamic reportingManagerFullname;
  dynamic reportingManagerGender;
  dynamic reportingManagerEmail;
  dynamic reportingManagerMobile;
  dynamic reportingManagerRole;
  num? reportingManagerRoleLevel;
  dynamic reportingManagerRoleGroup;
  num? reportingManagerRoleGroupLevel;
  num? latitude;
  num? longitude;
  dynamic currentLocationUpdatedOn;
  dynamic currentLocationUpdatedAt;
  bool? approved;

  UserModel(
      {this.id,
      this.countryId,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.unitId,
      this.unitCode,
      this.unitName,
      this.locationId,
      this.locationCode,
      this.locationName,
      this.address,
      this.userId,
      this.username,
      this.fullname,
      this.phone,
      this.mobile,
      this.email,
      this.gender,
      this.officeLatitude,
      this.officeLongitude,
      this.reportingManagerId,
      this.reportingManagerUsername,
      this.reportingManagerFullname,
      this.reportingManagerGender,
      this.reportingManagerEmail,
      this.reportingManagerMobile,
      this.reportingManagerRole,
      this.reportingManagerRoleLevel,
      this.reportingManagerRoleGroup,
      this.reportingManagerRoleGroupLevel,
      this.latitude,
      this.longitude,
      this.currentLocationUpdatedOn,
      this.currentLocationUpdatedAt,
      this.approved});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
