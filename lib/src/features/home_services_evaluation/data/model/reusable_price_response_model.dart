
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_price_response_entity.dart';

class ReusablePriceResponseModel extends ReusablePriceResponseEntity {
  ReusablePriceResponseModel({
    super.reusablePrice
  });

  ReusablePriceResponseModel.fromJson(dynamic json) {
    reusablePrice = json['reusablePrice'];
  }
}
