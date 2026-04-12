class CarPlateParser {
  static CarPlateParts parse(String input) {
    input = input.trim().replaceAll(RegExp(r'\s+'), ' ');
    final parts = input.split(' ');

    if (parts.length < 4) {
      return CarPlateParts.empty();
    }

    return CarPlateParts(
      first: parts[0],
      second: parts[1],
      third: parts[2],
      fourth: parts[3],
    );
  }
}

class CarPlateParts {
  final String first;
  final String second;
  final String third;
  final String fourth;

  const CarPlateParts({
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
  });

  factory CarPlateParts.empty() => const CarPlateParts(
        first: "",
        second: "",
        third: "",
        fourth: "",
      );
}
