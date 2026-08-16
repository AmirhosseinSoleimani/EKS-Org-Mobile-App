import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/emdad_service_category_model.dart';

class EmdadServiceCategoryEntity {
  const EmdadServiceCategoryEntity({
    this.id,
    this.serviceTypeId,
    this.serviceTypeTitle,
    this.code,
    this.title,
    this.orderNo,
  });

  final int? id;
  final int? serviceTypeId;
  final String? serviceTypeTitle;
  final String? code;
  final String? title;
  final int? orderNo;

  EmdadServiceCategoryModel toModel() {
    return EmdadServiceCategoryModel(
      id: id,
      serviceTypeId: serviceTypeId,
      serviceTypeTitle: serviceTypeTitle,
      code: code,
      title: title,
      orderNo: orderNo,
    );
  }
}
