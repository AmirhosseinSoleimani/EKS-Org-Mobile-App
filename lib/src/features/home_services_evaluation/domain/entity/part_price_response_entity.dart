import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/get_part_price_response_model.dart';

class PartPriceResponseEntity {
  int? price;
  String? currency;
  int? reusablePrice;
  bool? hasReusable;

  GetPartPriceResponseModel toModel() {
    return GetPartPriceResponseModel(
      price: price,
      currency: currency,
      reusablePrice: reusablePrice,
      hasReusable: hasReusable,
    );
  }

  PartPriceResponseEntity({
    this.price,
    this.currency,
    this.reusablePrice,
    this.hasReusable,
  });
}
