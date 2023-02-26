// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserImageAdapter extends TypeAdapter<UserImage> {
  @override
  final int typeId = 7;

  @override
  UserImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserImage(
      image: fields[0] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, UserImage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
