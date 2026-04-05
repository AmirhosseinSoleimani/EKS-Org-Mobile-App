import 'package:eks_sana_plus_org/src/shared/validator/validations/required_validation.dart';
import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';

class IranLicensePlateValidation extends Validation<String> {
  final String? fieldName;

  const IranLicensePlateValidation({this.fieldName});

  @override
  String? validate(String? value) {
    final requiredError =
    RequiredValidation<String>(fieldName: fieldName).validate(value);
    if (requiredError != null) return requiredError;

    final raw = (value ?? '').trim();
    final normalized = _normalize(raw);

    final parts = normalized.split(RegExp(r'\s+'));
    if (parts.length != 4) {
      return '${fieldName ?? "شماره پلاک"} معتبر نیست';
    }

    final p1 = parts[0];
    final tag = parts[1];
    final p2 = parts[2];
    final p3 = parts[3];

    if (!_isDigits(p1, len: 2)) return '${fieldName ?? "شماره پلاک"} معتبر نیست';
    if (!_isDigits(p2, len: 3)) return '${fieldName ?? "شماره پلاک"} معتبر نیست';
    if (!_isDigits(p3, len: 2)) return '${fieldName ?? "شماره پلاک"} معتبر نیست';

    if (tag.length != 1 || !_isPersianLetter(tag)) {
      return '${fieldName ?? "شماره پلاک"} معتبر نیست';
    }

    return null;
  }

  static String _normalize(String input) {
    final t = _toEnglishDigits(input);
    return t.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String _toEnglishDigits(String s) {
    const fa = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];
    const ar = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    var out = s;
    for (var i = 0; i < 10; i++) {
      out = out.replaceAll(fa[i], '$i');
      out = out.replaceAll(ar[i], '$i');
    }
    return out;
  }

  static bool _isDigits(String s, {required int len}) {
    if (s.length != len) return false;
    return RegExp(r'^\d+$').hasMatch(s);
  }

  static bool _isPersianLetter(String s) {
    return RegExp(r'^[\u0600-\u06FF]$').hasMatch(s);
  }
}
