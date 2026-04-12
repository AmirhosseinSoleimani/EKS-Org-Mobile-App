
class AddressInfoEntity {
  const AddressInfoEntity({
    this.longitude,
    this.latitude,
    this.address,
  });

  final String? address;
  final double? latitude;
  final double? longitude;

  AddressInfoEntity copyWith({
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return AddressInfoEntity(
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}