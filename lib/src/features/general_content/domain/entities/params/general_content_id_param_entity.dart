import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_id_request_model.dart';

class GeneralContentIdParamEntity {
  const GeneralContentIdParamEntity({required this.id});

  final int id;

  GeneralContentIdRequestModel toModel() {
    return GeneralContentIdRequestModel(id: id);
  }
}
