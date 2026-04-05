import 'package:flutter/services.dart';

class PersianArabicDigitsToEnglishFormatter extends TextInputFormatter {
  static const _fa = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];
  static const _ar = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var text = newValue.text;

    for (var i = 0; i < 10; i++) {
      text = text.replaceAll(_fa[i], i.toString());
      text = text.replaceAll(_ar[i], i.toString());
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
      composing: TextRange.empty,
    );
  }
}


