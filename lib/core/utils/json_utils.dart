class JsonUtils {
  JsonUtils._();

  static String getString(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];

    if (value == null) return '';

    return value.toString();
  }

  static String? getNullableString(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];

    if (value == null) return null;

    return value.toString();
  }

  static int getInt(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];

    if (value is int) return value;

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static bool getBool(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];

    if (value is bool) return value;

    return value.toString().toLowerCase() == 'true';
  }

  static DateTime? getDateTime(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];

    if (value == null) return null;

    return DateTime.tryParse(value.toString());
  }
}