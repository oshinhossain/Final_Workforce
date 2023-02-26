// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceAdapter extends TypeAdapter<Attendance> {
  @override
  final int typeId = 2;

  @override
  Attendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attendance(
      presentDay: fields[11] as DateTime?,
      locationType: fields[9] as String?,
      purpose: fields[0] as String?,
      attendanceEventType: fields[4] as String?,
      effectiveHours: fields[3] as int?,
      firstInTime: fields[5] as DateTime?,
      lat: fields[1] as num?,
      long: fields[2] as num?,
      isOfficeEnd: fields[8] as bool?,
      lastInTime: fields[6] as DateTime?,
      history: (fields[10] as List).cast<AttendanceHistory>(),
      lastOutTime: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Attendance obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.long)
      ..writeByte(3)
      ..write(obj.effectiveHours)
      ..writeByte(4)
      ..write(obj.attendanceEventType)
      ..writeByte(5)
      ..write(obj.firstInTime)
      ..writeByte(6)
      ..write(obj.lastInTime)
      ..writeByte(7)
      ..write(obj.lastOutTime)
      ..writeByte(8)
      ..write(obj.isOfficeEnd)
      ..writeByte(9)
      ..write(obj.locationType)
      ..writeByte(10)
      ..write(obj.history)
      ..writeByte(11)
      ..write(obj.presentDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
