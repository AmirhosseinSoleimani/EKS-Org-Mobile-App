extension IterableExtension on Iterable {
  String listToString() {
    StringBuffer stringBuffer = StringBuffer();
    forEach((element) {
      stringBuffer.write(element);
      stringBuffer.write('\n');
    });
    return stringBuffer.toString();
  }
}

extension ListExtension on List<String> {
  String listToString() {
    StringBuffer stringBuffer = StringBuffer();
    forEach((element) {
      stringBuffer.write(element);
      stringBuffer.write('\n');
    });
    return stringBuffer.toString();
  }
}
