import 'agency_info_entity.dart';

class AgencyInfoPageEntity {
  const AgencyInfoPageEntity({
    required this.records,
    required this.count,
  });

  final List<AgencyInfoEntity> records;
  final int count;
}
