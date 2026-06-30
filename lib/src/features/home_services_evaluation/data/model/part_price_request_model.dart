
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_price_request_entity.dart';

class PartPriceRequestModel extends PartPriceRequestEntity {
  PartPriceRequestModel({
    super.mark,
    super.serial,
    super.serviceType
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serial'] = serial;
    map['mark'] = mark;
    map['serviceType'] = serviceType;
    return map;
  }
}
