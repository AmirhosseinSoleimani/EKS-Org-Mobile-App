import '../../domain/entities/minimal_customer_info_entity.dart';

class MinimalCustomerInfoModel extends MinimalCustomerInfoEntity {
  const MinimalCustomerInfoModel({
    required super.firstName,
    required super.lastName,
    required super.nationalNo,
    required super.gender,
    required super.foreigner,
  });

  factory MinimalCustomerInfoModel.fromJson(Map<String, dynamic> json) {
    return MinimalCustomerInfoModel(
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      nationalNo: json["nationalNo"] ?? "",
      gender: json["gender"] ?? 0,
      foreigner: json["foreigner"] ?? false,
    );
  }
}
