import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_misc_entity.dart';

class CurrentSessionMiscModel extends CurrentSessionMiscEntity {
  const CurrentSessionMiscModel({
    super.currentYearGregorian,
    super.currentYearJalali,
    super.currentDateGregorian,
    super.currentDateJalali,
  });

  factory CurrentSessionMiscModel.fromJson(Map<String, dynamic> json) {
    return CurrentSessionMiscModel(
      currentYearGregorian: _toInt(json['currentYearGregorian']),
      currentYearJalali: _toInt(json['currentYearJalali']),
      currentDateGregorian: json['currentDateGregorian']?.toString(),
      currentDateJalali: json['currentDateJalali']?.toString(),
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
