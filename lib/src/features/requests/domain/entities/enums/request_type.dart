enum RequestType {
  reliefService(1),
  homeService(2);

  final int value;
  const RequestType(this.value);

  static RequestType? fromValue(int? value) {
    if (value == null) return null;
    return RequestType.values.firstWhere(
          (e) => e.value == value,
      orElse: () => RequestType.reliefService,
    );
  }
}