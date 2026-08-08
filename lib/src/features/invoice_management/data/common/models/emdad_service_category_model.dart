import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';

class EmdadServiceCategoryModel extends EmdadServiceCategoryEntity {
  const EmdadServiceCategoryModel({
    super.id,
    super.serviceTypeId,
    super.serviceTypeTitle,
    super.code,
    super.title,
    super.orderNo,
  });

  factory EmdadServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return EmdadServiceCategoryModel(
      id: JsonValueReader.intValue(json['id']),
      serviceTypeId: JsonValueReader.intValue(json['serviceTypeId']),
      serviceTypeTitle: JsonValueReader.stringValue(json['serviceTypeTitle']),
      code: JsonValueReader.stringValue(json['code']),
      title: JsonValueReader.stringValue(json['title']),
      orderNo: JsonValueReader.intValue(json['orderNo']),
    );
  }
}
