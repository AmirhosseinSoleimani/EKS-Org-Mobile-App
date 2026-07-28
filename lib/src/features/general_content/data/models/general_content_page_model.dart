import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_page_entity.dart';

class GeneralContentPageModel extends GeneralContentPageEntity {
  const GeneralContentPageModel({
    super.records,
    super.count,
  });

  factory GeneralContentPageModel.fromJson(Map<String, dynamic> json) {
    final records = GeneralContentJsonHelper.pageRecords(json)
        .map(GeneralContentModel.fromJson)
        .where((item) => item.id != null)
        .toList();

    return GeneralContentPageModel(
      records: records,
      count: GeneralContentJsonHelper.pageCount(json),
    );
  }
}
