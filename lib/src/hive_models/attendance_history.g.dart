// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceHistoryAdapter extends TypeAdapter<AttendanceHistory> {
  @override
  final int typeId = 3;

  @override
  AttendanceHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceHistory(
      eventType: fields[0] as String?,
      location: fields[2] as String?,
      purpose: fields[3] as String?,
      remarks: fields[4] as String?,
      time: fields[1] as String?,
      lastEffectime: fields[5] as int?,
      isFirst: fields[6] as bool,
      lastEffectime1: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceHistory obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.eventType)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.purpose)
      ..writeByte(4)
      ..write(obj.remarks)
      ..writeByte(5)
      ..write(obj.lastEffectime)
      ..writeByte(6)
      ..write(obj.isFirst)
      ..writeByte(7)
      ..write(obj.lastEffectime1);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
