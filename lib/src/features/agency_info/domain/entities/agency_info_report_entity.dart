import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_report_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';

class AgencyInfoReportEntity {
  const AgencyInfoReportEntity({
    this.items = const [],
  });

  final List<AgencyInfoEntity> items;

  AgencyInfoReportModel toModel() {
    return AgencyInfoReportModel(
      items: items.map((item) => item.toModel()).toList(),
    );
  }
}
