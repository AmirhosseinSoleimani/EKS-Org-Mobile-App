import 'package:eks_sana_plus_org/src/features/agency_info/data/models/person_info_search_request_model.dart';

class PersonInfoSearchParamEntity {
  const PersonInfoSearchParamEntity({this.searchValue});

  final String? searchValue;

  PersonInfoSearchRequestModel toModel() {
    return PersonInfoSearchRequestModel(searchValue: searchValue);
  }

  PersonInfoSearchParamEntity copyWith({String? searchValue}) {
    return PersonInfoSearchParamEntity(
      searchValue: searchValue ?? this.searchValue,
    );
  }
}
