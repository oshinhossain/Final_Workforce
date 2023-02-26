// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgencyModelAdapter extends TypeAdapter<AgencyModel> {
  @override
  final int typeId = 6;

  @override
  AgencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgencyModel(
      empId: fields[0] as String?,
      userId: fields[1] as String?,
      username: fields[2] as String?,
      fullname: fields[3] as String?,
      email: fields[4] as String?,
      mobile: fields[5] as String?,
      gender: fields[6] as String?,
      reportingManagerUsername: fields[7] as String?,
      reportingManagerFullname: fields[8] as String?,
      reportingManagerEmail: fields[9] as String?,
      reportingManagerMobile: fields[10] as String?,
      agencyId: fields[11] as String?,
      agencyCode: fields[12] as String?,
      agencyName: fields[13] as String?,
      countryId: fields[14] as String?,
      countryCode: fields[15] as String?,
      countryName: fields[16] as String?,
      latitude: fields[17] as num?,
      longitude: fields[18] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, AgencyModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.empId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.fullname)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.mobile)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.reportingManagerUsername)
      ..writeByte(8)
      ..write(obj.reportingManagerFullname)
      ..writeByte(9)
      ..write(obj.reportingManagerEmail)
      ..writeByte(10)
      ..write(obj.reportingManagerMobile)
      ..writeByte(11)
      ..write(obj.agencyId)
      ..writeByte(12)
      ..write(obj.agencyCode)
      ..writeByte(13)
      ..write(obj.agencyName)
      ..writeByte(14)
      ..write(obj.countryId)
      ..writeByte(15)
      ..write(obj.countryCode)
      ..writeByte(16)
      ..write(obj.countryName)
      ..writeByte(17)
      ..write(obj.latitude)
      ..writeByte(18)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyModel _$AgencyModelFromJson(Map<String, dynamic> json) => AgencyModel(
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
      countryId: json['countryId'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
    );

Map<String, dynamic> _$AgencyModelToJson(AgencyModel instance) =>
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
    };
