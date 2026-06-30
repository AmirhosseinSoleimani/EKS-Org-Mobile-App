import '../../data/models/minimal_customer_info_model.dart';

class MinimalCustomerInfoEntity {
  final String firstName;
  final String lastName;
  final String nationalNo;
  final int gender;
  final bool foreigner;

  const MinimalCustomerInfoEntity({
    required this.firstName,
    required this.lastName,
    required this.nationalNo,
    required this.gender,
    required this.foreigner,
  });

  MinimalCustomerInfoEntity copyWith({
    String? firstName,
    String? lastName,
    String? nationalNo,
    int? gender,
    bool? foreigner,
  }) {
    return MinimalCustomerInfoEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nationalNo: nationalNo ?? this.nationalNo,
      gender: gender ?? this.gender,
      foreigner: foreigner ?? this.foreigner,
    );
  }

  MinimalCustomerInfoModel toModel() {
    return MinimalCustomerInfoModel(
      firstName: firstName,
      lastName: lastName,
      nationalNo: nationalNo,
      gender: gender,
      foreigner: foreigner,
    );
  }
}
