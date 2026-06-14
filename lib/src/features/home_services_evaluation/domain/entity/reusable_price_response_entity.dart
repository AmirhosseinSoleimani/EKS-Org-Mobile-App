import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/reusable_price_response_model.dart';

class ReusablePriceResponseEntity {
  ReusablePriceResponseEntity({this.reusablePrice});

  int? reusablePrice;

  ReusablePriceResponseModel toModel() {
    return ReusablePriceResponseModel(reusablePrice: reusablePrice);
  }
}
