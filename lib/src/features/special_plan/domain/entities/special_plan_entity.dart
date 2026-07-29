import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_zone_entity.dart';

class SpecialPlanEntity {
  const SpecialPlanEntity({
    this.id,
    this.title,
    this.areaBaseInfoId,
    this.areaTitle,
    this.productId,
    this.productTitle,
    this.orderNo,
    this.hasHighPriority,
    this.onlySaipaCars,
    this.startDate,
    this.endDate,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertUserFullName,
    this.insertDateTimeJalali,
    this.updateDateTime,
    this.updateDateTimeJalali,
    this.provinceTitle,
    this.cityTitle,
    this.zoneInfoList = const [],
    this.isDeleted,
    this.isActive,
  });

  final int? id;
  final String? title;
  final int? areaBaseInfoId;
  final String? areaTitle;
  final int? productId;
  final String? productTitle;
  final int? orderNo;
  final bool? hasHighPriority;
  final bool? onlySaipaCars;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? updateUserFullName;
  final DateTime? insertDateTime;
  final String? insertUserFullName;
  final String? insertDateTimeJalali;
  final DateTime? updateDateTime;
  final String? updateDateTimeJalali;
  final String? provinceTitle;
  final String? cityTitle;
  final List<SpecialPlanZoneEntity> zoneInfoList;
  final bool? isDeleted;
  final bool? isActive;

  String get displayAreaTitle {
    final explicit = areaTitle?.trim();
    if (explicit?.isNotEmpty == true) return explicit!;
    if (zoneInfoList.isNotEmpty) {
      final zoneTitle = zoneInfoList.first.title?.trim();
      if (zoneTitle?.isNotEmpty == true) return zoneTitle!;
    }
    return 'سراسر کشور';
  }
}
