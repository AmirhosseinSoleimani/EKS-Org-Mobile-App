class DeviceInfoFilterRequestModel {
  const DeviceInfoFilterRequestModel();

  Map<String, dynamic> toJson() {
    return const {
      'Sort': [],
      'Filter': {
        'Logic': 'and',
        'Filters': [],
      },
    };
  }
}
