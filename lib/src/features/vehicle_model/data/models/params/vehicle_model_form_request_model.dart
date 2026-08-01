class VehicleModelFormRequestModel {
  const VehicleModelFormRequestModel({
    this.id,
    required this.code,
    required this.name,
    required this.navganTypeId,
    required this.isActive,
    required this.hasDepot,
  });

  final int? id;
  final String code;
  final String name;
  final int navganTypeId;
  final bool isActive;
  final bool hasDepot;

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'navganTypeId': navganTypeId,
      'isActive': isActive,
      'hasDepot': hasDepot,
    };
  }
}
