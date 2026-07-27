import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_id_request_model.dart';

class ImeiInfoIdParamEntity {
  const ImeiInfoIdParamEntity({required this.id});

  final int id;

  ImeiInfoIdRequestModel toModel() {
    return ImeiInfoIdRequestModel(id: id);
  }
}
