import 'package:path/path.dart' show extension;

String getExt({required String path}) {
  return extension(path);
}
