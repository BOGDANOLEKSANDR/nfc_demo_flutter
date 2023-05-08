import '../app_logger.dart';
import 'package:nfc_demo/core/utils/utils.dart';

extension MapExtension on Map {
  bool getBool(String key) {
    Map data = this;
    if (data.containsKey(key)) {
      if (data[key] is bool) {
        return data[key] ?? false;
      } else if (data[key] is int) {
        return data[key] == 1;
      } else if (data[key] is String) {
        return data[key] == '1' || data[key] == 'true';
      }
    }
    return false;
  }

  int getInt(String key, {int defaultValue = 0}) {
    Map data = this;

    if (data.containsKey(key) && data[key] != null && '${data[key]}'.isNotEmpty) return toInt(data[key]);
    return defaultValue;
  }

  double getDouble(String key) {
    Map data = this;

    if (data.containsKey(key) && data[key] != null) return toDouble(data[key]);
    return 0.0;
  }

  String getString(String key) {
    Map data = this;
    if (data.containsKey(key)) {
      if (data[key] is String) {
        return data[key] ?? '';
      } else {
        return data[key] != null ? data[key].toString() : '';
      }
    }
    return '';
  }

  List<T> getList<T>(String key) {
    Map data = this;
    if (data.containsKey(key)) if (data[key] is List<T>) return data[key] ?? <T>[];
    return <T>[];
  }
}

int toInt(Object value) {
  try {
    int number = int.parse('$value');
    return number;
  } on Exception catch (e, s) {
    getLogger().e("toInt Exception : $e\n$s");
  }
  return 0;
}

double toDouble(Object value) {
  try {
    double number = double.parse('$value');
    return number;
  } on Exception catch (e, s) {
    getLogger().e("toDouble Exception : $e\n$s");
  }
  return 0;
}
