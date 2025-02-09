class Validator {
  static String? isNotEmpty({
    required String value,
    required String error,
  }) =>
      value.isEmpty ? error : null;
}
