

import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_price_model.dart';

class PartPriceEntity {
  final int? price;
  final bool? hasReusable;

  const PartPriceEntity({
    this.price,
    this.hasReusable,
  });

  PartPriceModel toModel() {
    return PartPriceModel(
      price: price,
      hasReusable: hasReusable,
    );
  }

  PartPriceEntity copyWith({
    int? price,
    bool? hasReusable,
  }) {
    return PartPriceEntity(
      price: price ?? this.price,
      hasReusable: hasReusable ?? this.hasReusable,
    );
  }
}