// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocationModelAdapter extends TypeAdapter<UserLocationModel> {
  @override
  final int typeId = 6;

  @override
  UserLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocationModel(
      appCode: fields[1] as String?,
      appName: fields[2] as String?,
      empCode: fields[3] as String?,
      empName: fields[4] as String?,
      latitude: fields[5] as double?,
      longitude: fields[6] as double?,
      platform: fields[7] as String?,
      username: fields[8] as String?,
      personName: fields[9] as String?,
      visitDate: fields[10] as String?,
      visitTime: fields[11] as String?,
      wsIp: fields[12] as String?,
      wsName: fields[13] as String?,
      status: fields[14] as String?,
      ip: fields[15] as String?,
      mac: fields[16] as String?,
      imei: fields[17] as String?,
      frequency: fields[18] as String?,
      signalStrengthWifi: fields[19] as double?,
      signalStrengthMobile: fields[20] as double?,
      networkCountryIso: fields[21] as String?,
      networkOperator: fields[22] as String?,
      networkType: fields[23] as String?,
      networkOperatorName: fields[24] as String?,
      simCountryIso: fields[25] as String?,
      simOperatorName: fields[26] as String?,
      simOperator: fields[27] as String?,
      agencyCode: fields[28] as String?,
      projectCode: fields[29] as String?,
      assignId: fields[30] as String?,
      areaLevelFullCode: fields[31] as String?,
      areaType: fields[32] as String?,
      areaLevel: fields[33] as int?,
      refNumber: fields[34] as String?,
      broadcastEnabled: fields[35] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocationModel obj) {
    writer
      ..writeByte(35)
      ..writeByte(1)
      ..write(obj.appCode)
      ..writeByte(2)
      ..write(obj.appName)
      ..writeByte(3)
      ..write(obj.empCode)
      ..writeByte(4)
      ..write(obj.empName)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude)
      ..writeByte(7)
      ..write(obj.platform)
      ..writeByte(8)
      ..write(obj.username)
      ..writeByte(9)
      ..write(obj.personName)
      ..writeByte(10)
      ..write(obj.visitDate)
      ..writeByte(11)
      ..write(obj.visitTime)
      ..writeByte(12)
      ..write(obj.wsIp)
      ..writeByte(13)
      ..write(obj.wsName)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.ip)
      ..writeByte(16)
      ..write(obj.mac)
      ..writeByte(17)
      ..write(obj.imei)
      ..writeByte(18)
      ..write(obj.frequency)
      ..writeByte(19)
      ..write(obj.signalStrengthWifi)
      ..writeByte(20)
      ..write(obj.signalStrengthMobile)
      ..writeByte(21)
      ..write(obj.networkCountryIso)
      ..writeByte(22)
      ..write(obj.networkOperator)
      ..writeByte(23)
      ..write(obj.networkType)
      ..writeByte(24)
      ..write(obj.networkOperatorName)
      ..writeByte(25)
      ..write(obj.simCountryIso)
      ..writeByte(26)
      ..write(obj.simOperatorName)
      ..writeByte(27)
      ..write(obj.simOperator)
      ..writeByte(28)
      ..write(obj.agencyCode)
      ..writeByte(29)
      ..write(obj.projectCode)
      ..writeByte(30)
      ..write(obj.assignId)
      ..writeByte(31)
      ..write(obj.areaLevelFullCode)
      ..writeByte(32)
      ..write(obj.areaType)
      ..writeByte(33)
      ..write(obj.areaLevel)
      ..writeByte(34)
      ..write(obj.refNumber)
      ..writeByte(35)
      ..write(obj.broadcastEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationModel _$UserLocationModelFromJson(Map<String, dynamic> json) =>
    UserLocationModel(
      appCode: json['appCode'] as String?,
      appName: json['appName'] as String?,
      empCode: json['empCode'] as String?,
      empName: json['empName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      platform: json['platform'] as String?,
      username: json['username'] as String?,
      personName: json['personName'] as String?,
      visitDate: json['visitDate'] as String?,
      visitTime: json['visitTime'] as String?,
      wsIp: json['wsIp'] as String?,
      wsName: json['wsName'] as String?,
      status: json['status'] as String?,
      ip: json['ip'] as String?,
      mac: json['mac'] as String?,
      imei: json['imei'] as String?,
      frequency: json['frequency'] as String?,
      signalStrengthWifi: (json['signalStrengthWifi'] as num?)?.toDouble(),
      signalStrengthMobile: (json['signalStrengthMobile'] as num?)?.toDouble(),
      networkCountryIso: json['networkCountryIso'] as String?,
      networkOperator: json['networkOperator'] as String?,
      networkType: json['networkType'] as String?,
      networkOperatorName: json['networkOperatorName'] as String?,
      simCountryIso: json['simCountryIso'] as String?,
      simOperatorName: json['simOperatorName'] as String?,
      simOperator: json['simOperator'] as String?,
      agencyCode: json['agencyCode'] as String?,
      projectCode: json['projectCode'] as String?,
      assignId: json['assignId'] as String?,
      areaLevelFullCode: json['areaLevelFullCode'] as String?,
      areaType: json['areaType'] as String?,
      areaLevel: json['areaLevel'] as int?,
      refNumber: json['refNumber'] as String?,
      broadcastEnabled: json['broadcastEnabled'],
    );

Map<String, dynamic> _$UserLocationModelToJson(UserLocationModel instance) =>
    <String, dynamic>{
      'appCode': instance.appCode,
      'appName': instance.appName,
      'empCode': instance.empCode,
      'empName': instance.empName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'platform': instance.platform,
      'username': instance.username,
      'personName': instance.personName,
      'visitDate': instance.visitDate,
      'visitTime': instance.visitTime,
      'wsIp': instance.wsIp,
      'wsName': instance.wsName,
      'status': instance.status,
      'ip': instance.ip,
      'mac': instance.mac,
      'imei': instance.imei,
      'frequency': instance.frequency,
      'signalStrengthWifi': instance.signalStrengthWifi,
      'signalStrengthMobile': instance.signalStrengthMobile,
      'networkCountryIso': instance.networkCountryIso,
      'networkOperator': instance.networkOperator,
      'networkType': instance.networkType,
      'networkOperatorName': instance.networkOperatorName,
      'simCountryIso': instance.simCountryIso,
      'simOperatorName': instance.simOperatorName,
      'simOperator': instance.simOperator,
      'agencyCode': instance.agencyCode,
      'projectCode': instance.projectCode,
      'assignId': instance.assignId,
      'areaLevelFullCode': instance.areaLevelFullCode,
      'areaType': instance.areaType,
      'areaLevel': instance.areaLevel,
      'refNumber': instance.refNumber,
      'broadcastEnabled': instance.broadcastEnabled,
    };
