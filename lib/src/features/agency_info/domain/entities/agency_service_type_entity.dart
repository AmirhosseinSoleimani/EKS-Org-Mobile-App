import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_service_type_model.dart';

class AgencyServiceTypeEntity {
  const AgencyServiceTypeEntity({
    this.id,
    this.code,
    this.name,
    this.selectable,
  });

  final int? id;
  final String? code;
  final String? name;
  final bool? selectable;

  AgencyServiceTypeModel toModel() {
    return AgencyServiceTypeModel(
      id: id,
      code: code,
      name: name,
      selectable: selectable,
    );
  }

  AgencyServiceTypeEntity copyWith({
    int? id,
    String? code,
    String? name,
    bool? selectable,
  }) {
    return AgencyServiceTypeEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      selectable: selectable ?? this.selectable,
    );
  }
}
