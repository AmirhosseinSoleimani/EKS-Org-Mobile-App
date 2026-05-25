import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_price_param_entity.dart';


class PartPriceParamModel extends PartPriceParamEntity {
  const PartPriceParamModel({
    super.serial,
    super.mark,
  });

  Map<String, dynamic> toJson() {
    return {
      'Serial': serial,
      'Mark': mark,
    };
  }
}