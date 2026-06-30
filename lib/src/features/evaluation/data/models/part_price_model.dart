import '../../domain/entities/part_price_entity.dart';

class PartPriceModel extends PartPriceEntity {
  const PartPriceModel({
    super.price,
    super.hasReusable,
  });

  factory PartPriceModel.fromJson(Map<String, dynamic> json) {
    return PartPriceModel(
      price: json['price'],
      hasReusable: json['hasReusable'],
    );
  }
}