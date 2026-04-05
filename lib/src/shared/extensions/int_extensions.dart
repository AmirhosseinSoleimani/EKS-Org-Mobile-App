import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';

extension PriceFormattingExt on int? {
  static const _lrm = '\u200E';

  String toToman() {
    if (this == null) return '-';

    var formattedPrice = (this! / 10).toString();

    if (formattedPrice.endsWith('.0')) {
      formattedPrice = formattedPrice.substring(0, formattedPrice.length - 2);
    }

    formattedPrice = formattedPrice.splitPriceByComma();


    return '$_lrm$formattedPrice تومان';
  }

  String toTomanWithoutCurrency() {
    if (this == null) return '-';

    var formattedPrice = (this! / 10).toString();

    if (formattedPrice.endsWith('.0')) {
      formattedPrice = formattedPrice.substring(0, formattedPrice.length - 2);
    }

    formattedPrice = formattedPrice.splitPriceByComma();

    return '$_lrm$formattedPrice';
  }
}
