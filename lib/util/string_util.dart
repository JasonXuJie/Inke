class StringUtil {
  static bool isEmpty(String s) {
    return s == null || s.length == 0;
  }

  static bool isSpace(String s) {
    return s == null || s.trim().length == 0;
  }

  static String append(List<String> array) {
    var buffer = StringBuffer();
    array.forEach((s) {
      buffer.write(s);
    });
    return buffer.toString();
  }

  static bool equals(String a, String b) {
    if (a == b) return true;
    if (a != null && b != null && (a.length == b.length)) {
      if (a is String && b is String) {
        return a == b;
      }
    } else {
      return false;
    }
  }
}
