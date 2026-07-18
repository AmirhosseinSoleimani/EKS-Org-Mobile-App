import 'package:eks_sana_plus_org/src/features/agency_info/data/models/person_info_search_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';

class PersonInfoSearchPageEntity {
  const PersonInfoSearchPageEntity({
    this.records,
    this.count,
  });

  final List<PersonInfoSearchEntity>? records;
  final int? count;

  PersonInfoSearchPageModel toModel() {
    return PersonInfoSearchPageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }

  PersonInfoSearchPageEntity copyWith({
    List<PersonInfoSearchEntity>? records,
    int? count,
  }) {
    return PersonInfoSearchPageEntity(
      records: records ?? this.records,
      count: count ?? this.count,
    );
  }
}
