class ImeiInfoFilterRequestModel {
  const ImeiInfoFilterRequestModel({
    this.simNumber,
    this.avlSerial,
    this.deviceId,
    this.imei,
    this.isActive,
    required this.pageSize,
    required this.skip,
  });

  final String? simNumber;
  final String? avlSerial;
  final int? deviceId;
  final String? imei;
  final bool? isActive;
  final int pageSize;
  final int skip;

  Map<String, dynamic> toJson() {
    final filters = <Map<String, dynamic>>[];

    void addContains(String field, String? value) {
      final text = value?.trim();
      if (text == null || text.isEmpty) return;
      filters.add({
        'Field': field,
        'Operator': 'contains',
        'Value': text,
      });
    }

    addContains('SIMNumber', simNumber);
    addContains('avlSerial', avlSerial);
    addContains('imei', imei);

    if (deviceId != null) {
      filters.add({
        'Field': 'deviceId',
        'Value': deviceId,
      });
    }

    if (isActive != null) {
      filters.add({
        'Field': 'isActive',
        'Value': isActive,
      });
    }

    return {
      'Sort': const [],
      'Filter': {
        'Logic': 'and',
        'Filters': filters,
      },
      'PageSize': pageSize,
      'Skip': skip,
    };
  }
}
