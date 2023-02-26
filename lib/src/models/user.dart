import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class User {
  @HiveField(0)
  @JsonKey(name: 'personName')
  String? fullName;
// ----------------------------------

  @HiveField(1)
  @JsonKey(name: 'username')
  String? username;
  // ----------------------------------

  @HiveField(2)
  @JsonKey(name: 'homeAddress')
  String? address;
  // ----------------------------------

  @HiveField(3)
  String? token;

  // @HiveField(4)
  // @JsonKey(fromJson: _fromJson, toJson: _toJson)
  // Uint8List? image;
  // static Uint8List? _fromJson(Uint8List x) => Uint8List(x.length);
  // static Uint8List? _toJson(Uint8List? image) => image;

  User({
    this.fullName,
    this.username,
    this.address,
    this.token,
    // this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
