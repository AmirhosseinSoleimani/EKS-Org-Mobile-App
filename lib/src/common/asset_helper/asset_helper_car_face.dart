import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';

class AssetHelperCarFace {
  static const String _basePath = 'assets/images/png/';

  static const String changan = '${_basePath}car_changan.png';
  static const String pride = '${_basePath}car_pride.png';
  static const String quick = '${_basePath}car_quick.png';
  static const String saina = '${_basePath}car_saina.png';
  static const String serato = '${_basePath}car_serato.png';
  static const String shahin = '${_basePath}car_shahin.png';
  static const String tiba = '${_basePath}car_tiba.png';
  static const String vanet = '${_basePath}car_vanet.png';
  static const String prideHatchback = '${_basePath}car2_icon.png';
  static const String shadow = '${_basePath}car_shadow.png';
  static const String tondar90 = '${_basePath}tondar90.png';

  static String getImagePathStaringName(String name) {
    switch (name) {
      case 'h2l':
        return AssetHelperCarFace.shadow;
      case 'ريچ':
        return AssetHelperCarFace.shadow;
      case 'وانت نيسان زامياد':
        return AssetHelperCarFace.vanet;
      case 'سراتو':
        return AssetHelperCarFace.serato;
      case 'چانگانCS35':
        return AssetHelperCarFace.changan;
      case '(تندر90) لوگان':
        return AssetHelperCarFace.shadow;
      case 'ساندرو - استپ وي':
        return AssetHelperCarFace.shadow;
      case 'تيبا':
        return AssetHelperCarFace.tiba;
      case 'ساینا':
        return AssetHelperCarFace.saina;
      case 'کوئیک':
        return AssetHelperCarFace.quick;
      case 'پرايد(x100) ':
        return AssetHelperCarFace.pride;
      case 'پرايد ( 94 به قبل)':
        return AssetHelperCarFace.prideHatchback;
      case 'h330 برليانس':
        return AssetHelperCarFace.shadow;
      case 'برليانس h320':
        return AssetHelperCarFace.shadow;
      case 'h230 برليانس':
        return AssetHelperCarFace.shadow;
      case 'h220 برليانس':
        return AssetHelperCarFace.shadow;
      case '(s300) آريو':
        return AssetHelperCarFace.shadow;
      case 'چانگان eado':
        return AssetHelperCarFace.changan;
      case 'ريو':
        return AssetHelperCarFace.shadow;
      case 'زانتيا':
        return AssetHelperCarFace.shadow;
      case 'مگان':
        return AssetHelperCarFace.shadow;
      case 'شاهين':
        return AssetHelperCarFace.shahin;
      default:
        return AssetHelperCarFace.shadow;
    }
  }

  static String getImagePathByCarModelId(int? carModelId) {
    int modelId = carModelId ?? 503;
    return '${AppConstants.carImagesUrl}${modelId}_v1.png';
  }
}
