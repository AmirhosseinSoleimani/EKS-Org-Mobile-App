import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/repositories/invoice_common_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEmdadCategoriesUseCase {
  const GetEmdadCategoriesUseCase(this._repository);

  final InvoiceCommonRepository _repository;

  Future<ApiResult<List<EmdadServiceCategoryEntity>>> call() {
    return _repository.getEmdadCategories();
  }
}
