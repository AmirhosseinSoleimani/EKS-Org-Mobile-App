import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_zone_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';

class SpecialPlanModel extends SpecialPlanEntity {
  const SpecialPlanModel({
    super.id,
    super.title,
    super.areaBaseInfoId,
    super.areaTitle,
    super.productId,
    super.productTitle,
    super.orderNo,
    super.hasHighPriority,
    super.onlySaipaCars,
    super.startDate,
    super.endDate,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertUserFullName,
    super.insertDateTimeJalali,
    super.updateDateTime,
    super.updateDateTimeJalali,
    super.provinceTitle,
    super.cityTitle,
    super.zoneInfoList,
    super.isDeleted,
    super.isActive,
  });

  factory SpecialPlanModel.fromJson(Map<String, dynamic> json) {
    final zones = json['zoneInfoList'] ?? json['ZoneInfoList'];
    return SpecialPlanModel(
      id: SpecialPlanJsonHelper.integer(json['id'] ?? json['ID']),
      title: SpecialPlanJsonHelper.string(json['title'] ?? json['Title']),
      areaBaseInfoId: SpecialPlanJsonHelper.integer(
        json['areaBaseInfoId'] ?? json['AreaBaseInfoId'],
      ),
      areaTitle: SpecialPlanJsonHelper.string(
        json['areaTitle'] ??
            json['areaBaseInfoTitle'] ??
            json['AreaBaseInfoTitle'],
      ),
      productId: SpecialPlanJsonHelper.integer(
        json['productId'] ?? json['ProductId'],
      ),
      productTitle: SpecialPlanJsonHelper.string(
        json['productTitle'] ?? json['ProductTitle'],
      ),
      orderNo: SpecialPlanJsonHelper.integer(
        json['orderNo'] ?? json['OrderNo'],
      ),
      hasHighPriority: SpecialPlanJsonHelper.boolean(
        json['hasHighPriority'] ?? json['HasHighPriority'],
      ),
      onlySaipaCars: SpecialPlanJsonHelper.boolean(
        json['onlySaipaCars'] ?? json['OnlySaipaCars'],
      ),
      startDate: SpecialPlanJsonHelper.utcDateTime(
        json['startDate'] ?? json['StartDate'],
      ),
      endDate: SpecialPlanJsonHelper.utcDateTime(
        json['endDate'] ?? json['EndDate'],
      ),
      updateUserFullName: SpecialPlanJsonHelper.string(
        json['updateUserFullName'] ?? json['UpdateUserFullName'],
      ),
      insertDateTime: SpecialPlanJsonHelper.dateTime(
        json['insertDateTime'] ?? json['InsertDateTime'],
      ),
      insertUserFullName: SpecialPlanJsonHelper.string(
        json['insertUserFullName'] ?? json['InsertUserFullName'],
      ),
      insertDateTimeJalali: SpecialPlanJsonHelper.string(
        json['insertDateTimeJalali'] ?? json['InsertDateTimeJalali'],
      ),
      updateDateTime: SpecialPlanJsonHelper.dateTime(
        json['updateDateTime'] ?? json['UpdateDateTime'],
      ),
      updateDateTimeJalali: SpecialPlanJsonHelper.string(
        json['updateDateTimeJalali'] ?? json['UpdateDateTimeJalali'],
      ),
      provinceTitle: SpecialPlanJsonHelper.string(
        json['provinceTitle'] ?? json['ProvinceTitle'],
      ),
      cityTitle: SpecialPlanJsonHelper.string(
        json['cityTitle'] ?? json['CityTitle'],
      ),
      zoneInfoList: zones is List
          ? zones
              .whereType<Map>()
              .map(
                (item) => SpecialPlanZoneModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList(growable: false)
          : const [],
      isDeleted: SpecialPlanJsonHelper.boolean(
        json['isDeleted'] ?? json['IsDeleted'],
      ),
      isActive: SpecialPlanJsonHelper.boolean(
        json['isActive'] ?? json['IsActive'],
      ),
    );
  }
}
