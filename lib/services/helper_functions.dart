class HelperFunctions {
  static bool validateEmail(String? value) {
    if (value != null && value.isNotEmpty) {
      final RegExp emailRegExp = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      return emailRegExp.hasMatch(value);
    }
    return false;
  }
}
