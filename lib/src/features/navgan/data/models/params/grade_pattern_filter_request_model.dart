class GradePatternFilterRequestModel {
  const GradePatternFilterRequestModel();

  Map<String, dynamic> toJson() {
    return const {
      'Sort': [],
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {
            'Field': 'isActive',
            'Operator': 'eq',
            'Value': 'true',
          },
        ],
      },
    };
  }
}
