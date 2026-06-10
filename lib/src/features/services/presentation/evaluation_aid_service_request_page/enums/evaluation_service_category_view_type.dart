import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';

enum EvaluationServiceCategoryViewType {
  none,
  transport,
  laborAndPart,
}

extension ServiceCategoryEvaluationViewX on ServiceCategoryEntity? {
  EvaluationServiceCategoryViewType get evaluationViewType {
    final id = this?.id;
    final code = this?.code;

    if (id == 21 || code == 'HAML') {
      return EvaluationServiceCategoryViewType.transport;
    }

    if ((id == 8 || id == 10) && code == 'REPAIR_ON_PLACE') {
      return EvaluationServiceCategoryViewType.laborAndPart;
    }

    if (id == 1 || code == 'VISIT') {
      return EvaluationServiceCategoryViewType.none;
    }

    return EvaluationServiceCategoryViewType.none;
  }
}