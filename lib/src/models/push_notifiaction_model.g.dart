// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notifiaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PushNotificationModelAdapter extends TypeAdapter<PushNotificationModel> {
  @override
  final int typeId = 5;

  @override
  PushNotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PushNotificationModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      destPage: fields[2] as String?,
      transportOrderNo: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PushNotificationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.destPage)
      ..writeByte(3)
      ..write(obj.transportOrderNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
