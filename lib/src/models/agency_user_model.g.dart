// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyUserModel _$AgencyUserModelFromJson(Map<String, dynamic> json) =>
    AgencyUserModel(
      empId: json['empId'] as String?,
      userId: json['userId'] as String?,
      username: json['username'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      gender: json['gender'] as String?,
      reportingManagerUsername: json['reportingManagerUsername'] as String?,
      reportingManagerFullname: json['reportingManagerFullname'] as String?,
      reportingManagerEmail: json['reportingManagerEmail'] as String?,
      reportingManagerMobile: json['reportingManagerMobile'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      countryId: json['countryId'],
      countryCode: json['countryCode'],
      countryName: json['countryName'] as String?,
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
      currentLocationUpdatedOn: json['currentLocationUpdatedOn'],
      currentLocationUpdatedAt: json['currentLocationUpdatedAt'],
      roleModel: json['roleModel'] == null
          ? null
          : AgencyRoleModel.fromJson(json['roleModel'] as Map<String, dynamic>),
      myTeam: json['myTeam'],
    );

Map<String, dynamic> _$AgencyUserModelToJson(AgencyUserModel instance) =>
    <String, dynamic>{
      'empId': instance.empId,
      'userId': instance.userId,
      'username': instance.username,
      'fullname': instance.fullname,
      'email': instance.email,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'reportingManagerUsername': instance.reportingManagerUsername,
      'reportingManagerFullname': instance.reportingManagerFullname,
      'reportingManagerEmail': instance.reportingManagerEmail,
      'reportingManagerMobile': instance.reportingManagerMobile,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'countryId': instance.countryId,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'currentLocationUpdatedOn': instance.currentLocationUpdatedOn,
      'currentLocationUpdatedAt': instance.currentLocationUpdatedAt,
      'roleModel': instance.roleModel,
      'myTeam': instance.myTeam,
    };

AgencyRoleModel _$AgencyRoleModelFromJson(Map<String, dynamic> json) =>
    AgencyRoleModel(
      roleGroup: json['roleGroup'] as String?,
      roleGroupLevel: json['roleGroupLevel'] as int?,
      roleLevel: json['roleLevel'] as int?,
      roleName: json['roleName'] as String?,
      appCode: json['appCode'] as String?,
    );

Map<String, dynamic> _$AgencyRoleModelToJson(AgencyRoleModel instance) =>
    <String, dynamic>{
      'roleGroup': instance.roleGroup,
      'roleGroupLevel': instance.roleGroupLevel,
      'roleLevel': instance.roleLevel,
      'roleName': instance.roleName,
      'appCode': instance.appCode,
    };
