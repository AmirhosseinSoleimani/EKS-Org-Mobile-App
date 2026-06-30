import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/get_part_price_response_entity.dart';

class GetPartPriceResponseModel extends GetPartPriceResponseEntity {
  GetPartPriceResponseModel({
    super.price,
    super.currency,
    super.reusablePrice,
    super.hasReusable,
  });

  GetPartPriceResponseModel.fromJson(dynamic json) {
    price = json['price'];
    currency = json['currency'];
    reusablePrice = json['reusablePrice'];
    hasReusable = json['hasReusable'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    map['currency'] = currency;
    map['reusablePrice'] = reusablePrice;
    map['hasReusable'] = hasReusable;
    return map;
  }
}
