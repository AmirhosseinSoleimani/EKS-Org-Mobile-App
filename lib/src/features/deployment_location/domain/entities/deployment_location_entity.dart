class DeploymentLocationEntity {
  const DeploymentLocationEntity({
    this.id,
    this.title,
    this.address,
    this.latitude,
    this.longitude,
    this.cityId,
    this.cityTitle,
    this.provinceId,
    this.provinceTitle,
    this.isActive,
    this.insertFullName,
    this.insertDateTimeJalali,
    this.updateFullName,
  });

  final int? id;
  final String? title;
  final String? address;
  final double? latitude;
  final double? longitude;
  final int? cityId;
  final String? cityTitle;
  final int? provinceId;
  final String? provinceTitle;
  final bool? isActive;
  final String? insertFullName;
  final String? insertDateTimeJalali;
  final String? updateFullName;

  bool get hasCoordinates => latitude != null && longitude != null;
}
