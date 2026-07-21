import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_person_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_entity.dart';

class AgencyPersonPageEntity {
  const AgencyPersonPageEntity({
    this.records,
    this.count,
  });

  final List<AgencyPersonEntity>? records;
  final int? count;

  AgencyPersonPageModel toModel() {
    return AgencyPersonPageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }

  AgencyPersonPageEntity copyWith({
    List<AgencyPersonEntity>? records,
    int? count,
  }) {
    return AgencyPersonPageEntity(
      records: records ?? this.records,
      count: count ?? this.count,
    );
  }
}
