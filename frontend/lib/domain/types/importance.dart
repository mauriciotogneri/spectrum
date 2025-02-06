enum Importance {
  low,
  medium,
  high,
  critical;

  String get localized {
    switch (this) {
      case Importance.low:
        return 'low';
      case Importance.medium:
        return 'medium';
      case Importance.high:
        return 'high';
      case Importance.critical:
        return 'critical';
    }
  }
}
