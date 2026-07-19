import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_id_request_model.dart';

class AgencyIdParamEntity {
  const AgencyIdParamEntity({this.id});

  final int? id;

  AgencyIdRequestModel toModel() {
    return AgencyIdRequestModel(id: id);
  }

  AgencyIdParamEntity copyWith({int? id}) {
    return AgencyIdParamEntity(id: id ?? this.id);
  }
}
