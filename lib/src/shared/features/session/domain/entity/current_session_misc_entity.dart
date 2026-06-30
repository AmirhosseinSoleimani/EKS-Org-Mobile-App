
import '../../data/models/current_session_misc_model.dart';

class CurrentSessionMiscEntity {
  final int? currentYearGregorian;
  final int? currentYearJalali;
  final String? currentDateGregorian;
  final String? currentDateJalali;

  const CurrentSessionMiscEntity({
    this.currentYearGregorian,
    this.currentYearJalali,
    this.currentDateGregorian,
    this.currentDateJalali,
  });

  CurrentSessionMiscEntity copyWith({
    int? currentYearGregorian,
    int? currentYearJalali,
    String? currentDateGregorian,
    String? currentDateJalali,
  }) {
    return CurrentSessionMiscEntity(
      currentYearGregorian: currentYearGregorian ?? this.currentYearGregorian,
      currentYearJalali: currentYearJalali ?? this.currentYearJalali,
      currentDateGregorian: currentDateGregorian ?? this.currentDateGregorian,
      currentDateJalali: currentDateJalali ?? this.currentDateJalali,
    );
  }

  CurrentSessionMiscModel toModel() {
    return CurrentSessionMiscModel(
      currentYearGregorian: currentYearGregorian,
      currentYearJalali: currentYearJalali,
      currentDateGregorian: currentDateGregorian,
      currentDateJalali: currentDateJalali,
    );
  }
}
