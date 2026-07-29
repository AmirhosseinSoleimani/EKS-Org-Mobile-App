import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/get_special_plan_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/get_special_plan_products_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_report_state.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/services/special_plan_excel_report_factory.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SpecialPlanReportCubit extends Cubit<SpecialPlanReportState> {
  SpecialPlanReportCubit(
    this._getListUseCase,
    this._getProductsUseCase,
    this._exportExcelUseCase,
  ) : super(const SpecialPlanReportState());

  final GetSpecialPlanListUseCase _getListUseCase;
  final GetSpecialPlanProductsUseCase _getProductsUseCase;
  final ExportExcelUseCase _exportExcelUseCase;

  Future<bool> export({
    required SpecialPlanFilterParamEntity filter,
    required List<SpecialPlanProductEntity> cachedProducts,
  }) async {
    if (state.isLoading) return false;
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final products = await _resolveProducts(cachedProducts);
    final records = await _loadRecords(filter);
    if (records == null) return false;
    if (records.isEmpty) {
      _emitError('داده‌ای برای تهیه گزارش وجود ندارد.');
      return false;
    }

    final exportResult = await _exportExcelUseCase(
      SpecialPlanExcelReportFactory.create(
        records: records,
        products: products,
      ),
    );

    var success = false;
    exportResult.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isLoading: false,
            successMessage: 'فایل گزارش با موفقیت ذخیره شد.',
            errorMessage: null,
          ),
        );
      },
      failure: (error, failures) => _emitError(
        failures ?? 'ذخیره فایل گزارش با خطا مواجه شد.',
      ),
      expireToken: () => _emitError('نشست کاربری منقضی شده است.'),
      connectionError: () =>
          _emitError('ذخیره فایل گزارش با خطا مواجه شد.'),
    );
    return success;
  }

  Future<List<SpecialPlanProductEntity>> _resolveProducts(
    List<SpecialPlanProductEntity> cachedProducts,
  ) async {
    if (cachedProducts.isNotEmpty) return cachedProducts;

    var products = const <SpecialPlanProductEntity>[];
    final result = await _getProductsUseCase();
    result.when(
      success: (items, failures, resultCode) => products = items,
      failure: (error, failures) {},
      expireToken: () {},
      connectionError: () {},
    );
    return products;
  }

  Future<List<SpecialPlanEntity>?> _loadRecords(
    SpecialPlanFilterParamEntity filter,
  ) async {
    List<SpecialPlanEntity>? records;
    String? errorMessage;
    final result = await _getListUseCase(filter);
    result.when(
      success: (page, failures, resultCode) => records = page.records,
      failure: (error, failures) =>
          errorMessage = failures ?? 'دریافت اطلاعات گزارش ناموفق بود.',
      expireToken: () => errorMessage = 'نشست کاربری منقضی شده است.',
      connectionError: () => errorMessage = 'اتصال به اینترنت برقرار نیست.',
    );

    if (errorMessage != null) {
      _emitError(errorMessage!);
      return null;
    }
    return records ?? const [];
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        isLoading: false,
        errorMessage: message,
      ),
    );
  }

  void clearErrorMessage() => emit(state.copyWith(errorMessage: null));

  void clearSuccessMessage() => emit(state.copyWith(successMessage: null));
}
