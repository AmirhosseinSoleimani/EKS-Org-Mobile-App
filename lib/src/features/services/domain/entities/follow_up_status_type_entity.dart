import 'package:eks_sana_plus_org/src/features/services/data/models/follow_up_status_type_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class FollowUpStatusTypeEntity implements DropdownItem {
  final int? id;
  final String? code;
  final String? title;
  final int? sourceType;
  final bool? changesRequestStatus;
  final int? serviceRequestResultStatus;
  final bool? isActive;
  final bool? isDeleted;
  final String? sourceTypeName;
  final String? sourceTypeTitle;
  final String? serviceRequestResultStatusName;
  final String? serviceRequestResultStatusTitle;

  const FollowUpStatusTypeEntity({
    this.id,
    this.code,
    this.title,
    this.sourceType,
    this.changesRequestStatus,
    this.serviceRequestResultStatus,
    this.isActive,
    this.isDeleted,
    this.sourceTypeName,
    this.sourceTypeTitle,
    this.serviceRequestResultStatusName,
    this.serviceRequestResultStatusTitle,
  });

  bool shouldUpdateTimeLabel() {
    const validIds = {1, 4, 5, 14, 15};
    return id != null && validIds.contains(id);
  }

  FollowUpStatusTypeEntity copyWith({
    int? id,
    String? code,
    String? title,
    int? sourceType,
    bool? changesRequestStatus,
    int? serviceRequestResultStatus,
    bool? isActive,
    bool? isDeleted,
    String? sourceTypeName,
    String? sourceTypeTitle,
    String? serviceRequestResultStatusName,
    String? serviceRequestResultStatusTitle,
  }) {
    return FollowUpStatusTypeEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      sourceType: sourceType ?? this.sourceType,
      changesRequestStatus: changesRequestStatus ?? this.changesRequestStatus,
      serviceRequestResultStatus:
      serviceRequestResultStatus ?? this.serviceRequestResultStatus,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      sourceTypeName: sourceTypeName ?? this.sourceTypeName,
      sourceTypeTitle: sourceTypeTitle ?? this.sourceTypeTitle,
      serviceRequestResultStatusName:
      serviceRequestResultStatusName ?? this.serviceRequestResultStatusName,
      serviceRequestResultStatusTitle:
      serviceRequestResultStatusTitle ?? this.serviceRequestResultStatusTitle,
    );
  }

  FollowUpStatusTypeModel toModel() {
    return FollowUpStatusTypeModel(
      id: id,
      code: code,
      title: title,
      sourceType: sourceType,
      changesRequestStatus: changesRequestStatus,
      serviceRequestResultStatus: serviceRequestResultStatus,
      isActive: isActive,
      isDeleted: isDeleted,
      sourceTypeName: sourceTypeName,
      sourceTypeTitle: sourceTypeTitle,
      serviceRequestResultStatusName: serviceRequestResultStatusName,
      serviceRequestResultStatusTitle: serviceRequestResultStatusTitle,
    );
  }

  @override
  String get label => title ?? '';

  @override
  Widget? leading(BuildContext context) => null;

  @override
  get value => id;
}
