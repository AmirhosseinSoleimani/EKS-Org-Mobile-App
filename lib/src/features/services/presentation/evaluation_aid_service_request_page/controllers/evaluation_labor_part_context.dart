import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';

class EvaluationLaborPartContext {
  const EvaluationLaborPartContext({
    required this.selectedRequest,
    required this.emdadgarServiceDetailEntity,
    required this.lastEvaluationEntity,
    required this.customerKilometerText,
  });

  final ReliefRequestEntity? selectedRequest;
  final EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity;
  final ResponseLastEvaluationEntity? lastEvaluationEntity;
  final String customerKilometerText;
}
