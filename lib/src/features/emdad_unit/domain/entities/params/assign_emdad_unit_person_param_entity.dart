class AssignEmdadUnitPersonParamEntity {
  const AssignEmdadUnitPersonParamEntity({
    required this.agencyPersonId,
    required this.emdadUnitId,
  });

  final int agencyPersonId;
  final int emdadUnitId;

  Map<String, dynamic> toJson() {
    return {
      'agencyPersonId': agencyPersonId,
      'emdadUnitId': emdadUnitId,
    };
  }
}
