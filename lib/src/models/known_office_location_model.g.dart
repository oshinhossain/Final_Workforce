// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_office_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KnownOfficeLocationModelAdapter
    extends TypeAdapter<KnownOfficeLocationModel> {
  @override
  final int typeId = 16;

  @override
  KnownOfficeLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KnownOfficeLocationModel(
      id: fields[0] as String?,
      locationCode: fields[1] as String?,
      locationName: fields[2] as String?,
      agencyId: fields[6] as String?,
      agencyCode: fields[7] as String?,
      agencyName: fields[8] as String?,
      address: fields[3] as String?,
      latitude: fields[4] as double?,
      longitude: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, KnownOfficeLocationModel obj) {
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
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude)
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
      other is KnownOfficeLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnownOfficeLocationModel _$KnownOfficeLocationModelFromJson(
        Map<String, dynamic> json) =>
    KnownOfficeLocationModel(
      id: json['id'] as String?,
      locationCode: json['locationCode'] as String?,
      locationName: json['locationName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$KnownOfficeLocationModelToJson(
        KnownOfficeLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationCode': instance.locationCode,
      'locationName': instance.locationName,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
    };
