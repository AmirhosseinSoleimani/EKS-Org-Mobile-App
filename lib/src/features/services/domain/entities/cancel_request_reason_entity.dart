import 'package:eks_sana_plus_org/src/features/services/data/models/cancel_request_reason_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/src/widgets/framework.dart';

class CancelRequestReasonEntity implements DropdownItem {
  final int? id;
  final String? title;
  final int? orderNo;
  final int? type;
  final bool? canCreateInvoice;
  final int? serviceType;
  final int? detailType;
  final String? detailTypeTitle;
  final bool? needImage;
  final String? reasonActionTypeTitle;
  final bool? isActive;
  final bool? isDeleted;

  const CancelRequestReasonEntity({
    this.id,
    this.title,
    this.orderNo,
    this.type,
    this.canCreateInvoice,
    this.serviceType,
    this.detailType,
    this.detailTypeTitle,
    this.needImage,
    this.reasonActionTypeTitle,
    this.isActive,
    this.isDeleted,
  });

  CancelRequestReasonModel toModel() {
    return CancelRequestReasonModel(
      id: id,
      title: title,
      orderNo: orderNo,
      type: type,
      canCreateInvoice: canCreateInvoice,
      serviceType: serviceType,
      detailType: detailType,
      detailTypeTitle: detailTypeTitle,
      needImage: needImage,
      reasonActionTypeTitle: reasonActionTypeTitle,
      isActive: isActive,
      isDeleted: isDeleted,
    );
  }

  CancelRequestReasonEntity copyWith({
    int? id,
    String? title,
    int? orderNo,
    int? type,
    bool? canCreateInvoice,
    int? serviceType,
    int? detailType,
    String? detailTypeTitle,
    bool? needImage,
    String? reasonActionTypeTitle,
    bool? isActive,
    bool? isDeleted,
  }) {
    return CancelRequestReasonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      orderNo: orderNo ?? this.orderNo,
      type: type ?? this.type,
      canCreateInvoice: canCreateInvoice ?? this.canCreateInvoice,
      serviceType: serviceType ?? this.serviceType,
      detailType: detailType ?? this.detailType,
      detailTypeTitle: detailTypeTitle ?? this.detailTypeTitle,
      needImage: needImage ?? this.needImage,
      reasonActionTypeTitle:
      reasonActionTypeTitle ?? this.reasonActionTypeTitle,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  String get label => title ?? '';

  @override
  Widget? leading(BuildContext context) => null;

  @override
  get value => id;
}
