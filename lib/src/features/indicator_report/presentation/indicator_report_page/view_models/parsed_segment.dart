class ParsedSegment {
  final String label;
  final String value;
  final String? parenValue;

  const ParsedSegment({
    required this.label,
    required this.value,
    this.parenValue,
  });
}