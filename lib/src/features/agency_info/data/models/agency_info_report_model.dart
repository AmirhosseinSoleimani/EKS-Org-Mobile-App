import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_report_entity.dart';

class AgencyInfoReportModel extends AgencyInfoReportEntity {
  const AgencyInfoReportModel({
    super.items = const [],
  });

  factory AgencyInfoReportModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json['Data'];
    final records = data is Map<String, dynamic>
        ? data['records'] ?? data['Records']
        : json['records'] ?? json['Records'];

    return AgencyInfoReportModel(
      items: records is List
          ? records
              .whereType<Map>()
              .map((item) => AgencyInfoModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ))
              .toList()
          : const [],
    );
  }
}
