import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_id_request_model.dart';

class NavganIdParamEntity {
  const NavganIdParamEntity({required this.id});

  final int id;

  NavganIdRequestModel toModel() => NavganIdRequestModel(id: id);
}
