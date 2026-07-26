import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_validation_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ValidateShiftUseCase
    extends BaseUseCase<ShiftValidationResult, ShiftEntity> {
  static const int titleMaxLength = 30;

  @override
  Future<ShiftValidationResult> call(ShiftEntity arg) async {
    if (arg.type == null) {
      return const ShiftValidationResult.invalid('نوع شیفت الزامی است');
    }

    final title = arg.title?.trim();
    if (title == null || title.isEmpty) {
      return const ShiftValidationResult.invalid('عنوان شیفت الزامی است');
    }
    if (title.length > titleMaxLength) {
      return const ShiftValidationResult.invalid(
        'عنوان شیفت باید حداکثر ۳۰ کاراکتر باشد',
      );
    }

    final startTime = arg.startTime?.trim();
    if (startTime == null || startTime.isEmpty) {
      return const ShiftValidationResult.invalid('زمان شروع الزامی است');
    }
    if (!_isValidTime(startTime)) {
      return const ShiftValidationResult.invalid(
        'زمان شروع باید با فرمت HH:mm وارد شود',
      );
    }

    final endTime = arg.endTime?.trim();
    if (endTime == null || endTime.isEmpty) {
      return const ShiftValidationResult.invalid('زمان پایان الزامی است');
    }
    if (!_isValidTime(endTime)) {
      return const ShiftValidationResult.invalid(
        'زمان پایان باید با فرمت HH:mm وارد شود',
      );
    }

    return const ShiftValidationResult.valid();
  }

  bool _isValidTime(String value) {
    final match = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').firstMatch(value);
    return match != null;
  }
}
