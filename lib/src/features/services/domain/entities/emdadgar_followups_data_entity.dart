import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_followups_data_model.dart';

class EmdadgarFollowupsDataEntity {
  final String? startTime;
  final DateTime? startTimeDate;
  final String? startTimeFollowUpName;

  final String? arrivedTime;
  final DateTime? arrivedTimeDate;
  final String? arrivedTimeFollowUpName;

  final String? endTime;
  final DateTime? endTimeDate;
  final String? endTimeFollowUpName;

  final bool? isArrivedDateEditable;
  final bool? isKilometerEditable;
  final bool? isHamlKilometerEditable;
  final bool? isEtmamWorkDateEditable;

  const EmdadgarFollowupsDataEntity({
    this.startTime,
    this.startTimeDate,
    this.startTimeFollowUpName,
    this.arrivedTime,
    this.arrivedTimeDate,
    this.arrivedTimeFollowUpName,
    this.endTime,
    this.endTimeDate,
    this.endTimeFollowUpName,
    this.isArrivedDateEditable,
    this.isKilometerEditable,
    this.isHamlKilometerEditable,
    this.isEtmamWorkDateEditable,
  });

  EmdadgarFollowupsDataEntity copyWith({
    String? startTime,
    DateTime? startTimeDate,
    String? startTimeFollowUpName,
    String? arrivedTime,
    DateTime? arrivedTimeDate,
    String? arrivedTimeFollowUpName,
    String? endTime,
    DateTime? endTimeDate,
    String? endTimeFollowUpName,
    bool? isArrivedDateEditable,
    bool? isKilometerEditable,
    bool? isHamlKilometerEditable,
    bool? isEtmamWorkDateEditable,
  }) {
    return EmdadgarFollowupsDataEntity(
      startTime: startTime ?? this.startTime,
      startTimeDate: startTimeDate ?? this.startTimeDate,
      startTimeFollowUpName:
      startTimeFollowUpName ?? this.startTimeFollowUpName,
      arrivedTime: arrivedTime ?? this.arrivedTime,
      arrivedTimeDate: arrivedTimeDate ?? this.arrivedTimeDate,
      arrivedTimeFollowUpName:
      arrivedTimeFollowUpName ?? this.arrivedTimeFollowUpName,
      endTime: endTime ?? this.endTime,
      endTimeDate: endTimeDate ?? this.endTimeDate,
      endTimeFollowUpName:
      endTimeFollowUpName ?? this.endTimeFollowUpName,
      isArrivedDateEditable:
      isArrivedDateEditable ?? this.isArrivedDateEditable,
      isKilometerEditable:
      isKilometerEditable ?? this.isKilometerEditable,
      isHamlKilometerEditable:
      isHamlKilometerEditable ?? this.isHamlKilometerEditable,
      isEtmamWorkDateEditable:
      isEtmamWorkDateEditable ?? this.isEtmamWorkDateEditable,
    );
  }

  EmdadgarFollowupsDataModel toModel() =>
      EmdadgarFollowupsDataModel.fromEntity(this);
}
