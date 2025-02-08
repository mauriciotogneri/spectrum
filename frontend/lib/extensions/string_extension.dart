extension StringExtension on String {
  bool matches(String query) =>
      trim().toLowerCase().contains(query.trim().toLowerCase());
}
