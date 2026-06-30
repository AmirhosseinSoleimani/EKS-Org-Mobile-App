

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_price_response_entity.dart';

class PartPriceResponseModel extends PartPriceResponseEntity {
  PartPriceResponseModel({
   super.currency,
   super.hasReusable,
   super.price,
   super.reusablePrice
  });

  PartPriceResponseModel.fromJson(dynamic json) {
    price = json['price'];
    currency = json['currency'];
    reusablePrice = json['reusablePrice'];
    hasReusable = json['hasReusable'];
  }
}