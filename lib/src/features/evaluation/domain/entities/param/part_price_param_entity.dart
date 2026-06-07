import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/part_price_param_model.dart';


class PartPriceParamEntity {
  final String? serial;
  final String? mark;

  const PartPriceParamEntity({
    this.serial,
    this.mark,
  });

  PartPriceParamModel toModel() {
    return PartPriceParamModel(
      serial: serial,
      mark: mark,
    );
  }

  PartPriceParamEntity copyWith({
    String? serial,
    String? mark,
  }) {
    return PartPriceParamEntity(
      serial: serial ?? this.serial,
      mark: mark ?? this.mark,
    );
  }
}