import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/imei_info_model.dart';

class ImeiInfoEntity {
  final int? id;
  final String? title;

  const ImeiInfoEntity({
    this.id,
    this.title,
  });

  ImeiInfoModel toModel() {
    return ImeiInfoModel(
      id: id,
      title: title,
    );
  }

  ImeiInfoEntity copyWith({
    int? id,
    String? title,
  }) {
    return ImeiInfoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
