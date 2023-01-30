import 'package:uuid/uuid.dart';

class DataUtil {
  static String makeFilePath(String ext) {
    return '${const Uuid().v4()}.$ext';
  }
}
