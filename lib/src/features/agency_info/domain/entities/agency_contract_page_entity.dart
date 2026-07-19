import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_contract_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_entity.dart';

class AgencyContractPageEntity {
  const AgencyContractPageEntity({
    this.records,
    this.count,
  });

  final List<AgencyContractEntity>? records;
  final int? count;

  AgencyContractPageModel toModel() {
    return AgencyContractPageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }

  AgencyContractPageEntity copyWith({
    List<AgencyContractEntity>? records,
    int? count,
  }) {
    return AgencyContractPageEntity(
      records: records ?? this.records,
      count: count ?? this.count,
    );
  }
}
