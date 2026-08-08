import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';

class EmdadServiceCategoryModel extends EmdadServiceCategoryEntity {
  const EmdadServiceCategoryModel({
    required super.id,
    required super.serviceTypeId,
    required super.serviceTypeTitle,
    required super.code,
    required super.title,
    required super.orderNo,
  });

  factory EmdadServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return EmdadServiceCategoryModel(
      id: JsonValueReader.intValue(json['id']) ?? 0,
      serviceTypeId: JsonValueReader.intValue(json['serviceTypeId']) ?? 0,
      serviceTypeTitle: JsonValueReader.stringValue(json['serviceTypeTitle']) ?? '',
      code: JsonValueReader.stringValue(json['code']) ?? '',
      title: JsonValueReader.stringValue(json['title']) ?? '',
      orderNo: JsonValueReader.intValue(json['orderNo']) ?? 0,
    );
  }
}
