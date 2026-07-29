class DeploymentLocationFilterParamEntity {
  const DeploymentLocationFilterParamEntity({
    this.skip = 0,
    this.pageSize = 10,
    this.title,
    this.provinceTitle,
    this.cityTitle,
    this.address,
    this.isActive,
  });

  final int skip;
  final int pageSize;
  final String? title;
  final String? provinceTitle;
  final String? cityTitle;
  final String? address;
  final bool? isActive;
}
