import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_price_request_model.dart';

class PartPriceRequestEntity {
  String? serial;
  String? mark;
  int? serviceType;

  PartPriceRequestModel toModel() {
    return PartPriceRequestModel(
      serial: serial,
      mark: mark,
      serviceType: serviceType,
    );
  }

  PartPriceRequestEntity({this.serial, this.mark, this.serviceType});
}
