import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';

class ImeiInfoPageEntity {
  const ImeiInfoPageEntity({
    this.records = const [],
    this.count = 0,
  });

  final List<ImeiInfoEntity> records;
  final int count;

  ImeiInfoPageModel toModel() {
    return ImeiInfoPageModel(
      records: records.map((item) => item.toModel()).toList(),
      count: count,
    );
  }
}
