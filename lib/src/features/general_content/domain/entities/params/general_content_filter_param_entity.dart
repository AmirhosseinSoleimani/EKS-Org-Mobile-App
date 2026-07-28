class GeneralContentFilterParamEntity {
  const GeneralContentFilterParamEntity({
    this.skip = 0,
    this.pageSize = 10,
    this.title,
    this.contentType,
  });

  final int skip;
  final int pageSize;
  final String? title;
  final int? contentType;
}
