class ReusableEntity {
  final String? name;
  final int? price;
  final bool? hasReusable;
  final bool? isActive;
  final String? serial;

  const ReusableEntity({
    this.name,
    this.price,
    this.hasReusable,
    this.isActive,
    this.serial,
  });

  ReusableEntity copyWith({
    String? name,
    int? price,
    bool? hasReusable,
    bool? isActive,
    String? serial,
  }) {
    return ReusableEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      hasReusable: hasReusable ?? this.hasReusable,
      isActive: isActive ?? this.isActive,
      serial: serial ?? this.serial,
    );
  }
}
