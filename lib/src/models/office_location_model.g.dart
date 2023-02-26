// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfficeLocationModelAdapter extends TypeAdapter<OfficeLocationModel> {
  @override
  final int typeId = 15;

  @override
  OfficeLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfficeLocationModel(
      id: fields[0] as String?,
      locationCode: fields[1] as String?,
      locationName: fields[2] as String?,
      agencyId: fields[6] as String?,
      agencyCode: fields[7] as String?,
      agencyName: fields[8] as String?,
      address: fields[3] as String?,
      officeLatitude: fields[4] as double?,
      officeLongitude: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, OfficeLocationModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.locationCode)
      ..writeByte(2)
      ..write(obj.locationName)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.officeLatitude)
      ..writeByte(5)
      ..write(obj.officeLongitude)
      ..writeByte(6)
      ..write(obj.agencyId)
      ..writeByte(7)
      ..write(obj.agencyCode)
      ..writeByte(8)
      ..write(obj.agencyName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficeLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeLocationModel _$OfficeLocationModelFromJson(Map<String, dynamic> json) =>
    OfficeLocationModel(
      id: json['id'] as String?,
      locationCode: json['locationCode'] as String?,
      locationName: json['locationName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      address: json['address'] as String?,
      officeLatitude: (json['officeLatitude'] as num?)?.toDouble(),
      officeLongitude: (json['officeLongitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OfficeLocationModelToJson(
        OfficeLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationCode': instance.locationCode,
      'locationName': instance.locationName,
      'address': instance.address,
      'officeLatitude': instance.officeLatitude,
      'officeLongitude': instance.officeLongitude,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
    };
