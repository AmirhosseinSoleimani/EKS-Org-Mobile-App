import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_page_entity.dart';

class ImeiInfoPageModel extends ImeiInfoPageEntity {
  const ImeiInfoPageModel({
    super.records,
    super.count,
  });

  factory ImeiInfoPageModel.fromJson(Map<String, dynamic> json) {
    final records = ImeiJsonHelper.pageRecords(json)
        .map(ImeiInfoModel.fromJson)
        .toList();

    return ImeiInfoPageModel(
      records: records,
      count: ImeiJsonHelper.pageCount(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'records': records.map((item) => item.toModel().toJson()).toList(),
      'count': count,
    };
  }
}
