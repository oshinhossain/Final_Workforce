import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_image.g.dart';

@HiveType(typeId: 7)
class UserImage {
  @HiveField(0)
  Uint8List? image;

  UserImage({
    this.image,
  });
}
