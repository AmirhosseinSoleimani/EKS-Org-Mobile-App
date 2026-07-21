import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_page_model.dart';
import 'agency_info_entity.dart';

class AgencyInfoPageEntity {
  const AgencyInfoPageEntity({
    required this.records,
    required this.count,
  });

  final List<AgencyInfoEntity> records;
  final int count;

  AgencyInfoPageModel toModel() {
    return AgencyInfoPageModel(
      records: records.map((item) => item.toModel()).toList(),
      count: count,
    );
  }

  AgencyInfoPageEntity copyWith({
    List<AgencyInfoEntity>? records,
    int? count,
  }) {
    return AgencyInfoPageEntity(
      records: records ?? this.records,
      count: count ?? this.count,
    );
  }
}
