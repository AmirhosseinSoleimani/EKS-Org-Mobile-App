import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_validation_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ValidateGradePatternUseCase
    extends BaseUseCase<GradePatternValidationResult, GradePatternEntity> {
  @override
  Future<GradePatternValidationResult> call(GradePatternEntity arg) async {
    final name = arg.name?.trim();
    if (name == null || name.isEmpty) {
      return const GradePatternValidationResult.invalid(
        'نام الگوی گرید اجباری می باشد',
      );
    }

    for (final detail in arg.details) {
      final coefficient = detail.gradeCoefficient;
      if (coefficient < 0) {
        return GradePatternValidationResult.invalid(
          'مقدار ضریب گرید ${detail.gradeTitle} باید بزرگ‌تر یا برابر ۰ باشد',
        );
      }
      if (coefficient > 100) {
        return GradePatternValidationResult.invalid(
          'مقدار ضریب گرید ${detail.gradeTitle} باید کوچک‌تر یا برابر ۱۰۰ باشد',
        );
      }

      final commission = detail.managmentCommisionPercent;
      if (commission < 0) {
        return GradePatternValidationResult.invalid(
          'درصد کمیسیون مدیریت ${detail.gradeTitle} باید بزرگ‌تر یا برابر ۰ باشد',
        );
      }
      if (commission > 100) {
        return GradePatternValidationResult.invalid(
          'درصد کمیسیون مدیریت ${detail.gradeTitle} باید کوچک‌تر یا برابر ۱۰۰ باشد',
        );
      }
    }

    return const GradePatternValidationResult.valid();
  }
}
