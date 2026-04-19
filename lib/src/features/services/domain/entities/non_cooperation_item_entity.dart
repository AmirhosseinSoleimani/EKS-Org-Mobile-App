import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_item_model.dart';

class NonCooperationItemEntity {
  final int? id;
  final int? emdadgarInfoId;
  final String? agencyCode;
  final String? agencyName;
  final int? cityId;
  final String? cityName;
  final int? provinceId;
  final String? provinceName;
  final int? customerCityId;
  final String? customerCityName;
  final int? customerProvinceId;
  final String? customerProvinceName;
  final int? aidPerCode;
  final String? aidPerName;
  final int? serviceRequestTrackCode;
  final int? typeOfLack;
  final String? typeOfLackTitle;
  final int? authorId;
  final String? authorFullname;
  final String? submitDateTime;
  final String? callDateTime;
  final int? customerType;
  final String? customerTypeName;
  final String? customerTypeTitle;
  final String? description;
  final String? submitDateJalali;
  final String? submitTime;
  final String? callDateJalali;
  final String? callTime;
  final int? serviceRequestId;
  final int? serviceType;

  NonCooperationItemEntity({
    this.id,
    this.emdadgarInfoId,
    this.agencyCode,
    this.agencyName,
    this.cityId,
    this.cityName,
    this.provinceId,
    this.provinceName,
    this.customerCityId,
    this.customerCityName,
    this.customerProvinceId,
    this.customerProvinceName,
    this.aidPerCode,
    this.aidPerName,
    this.serviceRequestTrackCode,
    this.typeOfLack,
    this.typeOfLackTitle,
    this.authorId,
    this.authorFullname,
    this.submitDateTime,
    this.callDateTime,
    this.customerType,
    this.customerTypeName,
    this.customerTypeTitle,
    this.description,
    this.submitDateJalali,
    this.submitTime,
    this.callDateJalali,
    this.callTime,
    this.serviceRequestId,
    this.serviceType,
  });

  NonCooperationItemEntity copyWith({
    int? id,
    int? emdadgarInfoId,
    String? agencyCode,
    String? agencyName,
    int? cityId,
    String? cityName,
    int? provinceId,
    String? provinceName,
    int? customerCityId,
    String? customerCityName,
    int? customerProvinceId,
    String? customerProvinceName,
    int? aidPerCode,
    String? aidPerName,
    int? serviceRequestTrackCode,
    int? typeOfLack,
    String? typeOfLackTitle,
    int? authorId,
    String? authorFullname,
    String? submitDateTime,
    String? callDateTime,
    int? customerType,
    String? customerTypeName,
    String? customerTypeTitle,
    String? description,
    String? submitDateJalali,
    String? submitTime,
    String? callDateJalali,
    String? callTime,
    int? serviceRequestId,
    int? serviceType,
  }) {
    return NonCooperationItemEntity(
      id: id ?? this.id,
      emdadgarInfoId: emdadgarInfoId ?? this.emdadgarInfoId,
      agencyCode: agencyCode ?? this.agencyCode,
      agencyName: agencyName ?? this.agencyName,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      provinceId: provinceId ?? this.provinceId,
      provinceName: provinceName ?? this.provinceName,
      customerCityId: customerCityId ?? this.customerCityId,
      customerCityName: customerCityName ?? this.customerCityName,
      customerProvinceId: customerProvinceId ?? this.customerProvinceId,
      customerProvinceName: customerProvinceName ?? this.customerProvinceName,
      aidPerCode: aidPerCode ?? this.aidPerCode,
      aidPerName: aidPerName ?? this.aidPerName,
      serviceRequestTrackCode:
          serviceRequestTrackCode ?? this.serviceRequestTrackCode,
      typeOfLack: typeOfLack ?? this.typeOfLack,
      typeOfLackTitle: typeOfLackTitle ?? this.typeOfLackTitle,
      authorId: authorId ?? this.authorId,
      authorFullname: authorFullname ?? this.authorFullname,
      submitDateTime: submitDateTime ?? this.submitDateTime,
      callDateTime: callDateTime ?? this.callDateTime,
      customerType: customerType ?? this.customerType,
      customerTypeName: customerTypeName ?? this.customerTypeName,
      customerTypeTitle: customerTypeTitle ?? this.customerTypeTitle,
      description: description ?? this.description,
      submitDateJalali: submitDateJalali ?? this.submitDateJalali,
      submitTime: submitTime ?? this.submitTime,
      callDateJalali: callDateJalali ?? this.callDateJalali,
      callTime: callTime ?? this.callTime,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  NonCooperationItemModel toModel() {
    return NonCooperationItemModel(
      id: id,
      emdadgarInfoId: emdadgarInfoId,
      agencyCode: agencyCode,
      agencyName: agencyName,
      cityId: cityId,
      cityName: cityName,
      provinceId: provinceId,
      provinceName: provinceName,
      customerCityId: customerCityId,
      customerCityName: customerCityName,
      customerProvinceId: customerProvinceId,
      customerProvinceName: customerProvinceName,
      aidPerCode: aidPerCode,
      aidPerName: aidPerName,
      serviceRequestTrackCode: serviceRequestTrackCode,
      typeOfLack: typeOfLack,
      typeOfLackTitle: typeOfLackTitle,
      authorId: authorId,
      authorFullname: authorFullname,
      submitDateTime: submitDateTime,
      callDateTime: callDateTime,
      customerType: customerType,
      customerTypeName: customerTypeName,
      customerTypeTitle: customerTypeTitle,
      description: description,
      submitDateJalali: submitDateJalali,
      submitTime: submitTime,
      callDateJalali: callDateJalali,
      callTime: callTime,
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
    );
  }
}
