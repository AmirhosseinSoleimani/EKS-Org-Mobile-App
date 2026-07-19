import 'package:eks_sana_plus_org/src/features/agency_info/data/models/delete_agency_request_model.dart';

class DeleteAgencyParamEntity {
  const DeleteAgencyParamEntity({required this.id});

  final int id;

  DeleteAgencyRequestModel toModel() {
    return DeleteAgencyRequestModel(id: id);
  }
}
