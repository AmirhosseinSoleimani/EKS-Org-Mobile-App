import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/create_special_plan_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/get_special_plan_products_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/usecases/update_special_plan_use_case.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_form_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_discountable_areas_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SpecialPlanFormCubit extends Cubit<SpecialPlanFormState> {
  SpecialPlanFormCubit(
    this._getProductsUseCase,
    this._getDiscountableAreasUseCase,
    this._createUseCase,
    this._updateUseCase,
  ) : super(const SpecialPlanFormState());

  final GetSpecialPlanProductsUseCase _getProductsUseCase;
  final GetDiscountableAreasUseCase _getDiscountableAreasUseCase;
  final CreateSpecialPlanUseCase _createUseCase;
  final UpdateSpecialPlanUseCase _updateUseCase;

  Future<void> initialize() async {
    if (state.isLoading) return;
    emit(
      state.copyWith(
        isLoading: true,
        loadFailed: false,
        errorMessage: null,
      ),
    );

    final results = await Future.wait([
      _loadProducts(),
      _loadAreas(),
    ]);
    final areasLoaded = results[1];

    if (!areasLoaded || state.discountableAreas.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          loadFailed: true,
          errorMessage: 'دریافت محدوده‌های جغرافیایی با خطا مواجه شد.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        loadFailed: false,
        errorMessage: null,
      ),
    );
  }

  Future<bool> submit(SpecialPlanFormParamEntity param) async {
    if (state.isSubmitting) return false;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final result = param.id == null
        ? await _createUseCase(param)
        : await _updateUseCase(param);
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(isSubmitting: false, errorMessage: null));
      },
      failure: (error, failures) => _emitSubmitError(
        failures ?? 'ثبت طرح با خطا مواجه شد.',
      ),
      expireToken: () =>
          _emitSubmitError('نشست کاربری منقضی شده است.'),
      connectionError: () =>
          _emitSubmitError('اتصال به اینترنت برقرار نیست.'),
    );
    return success;
  }

  Future<bool> _loadProducts() async {
    final result = await _getProductsUseCase();
    var loaded = false;
    result.when(
      success: (items, failures, resultCode) {
        loaded = true;
        emit(
          state.copyWith(
            products: items
                .where((item) => item.id > 0 && item.title.trim().isNotEmpty)
                .toList(growable: false),
          ),
        );
      },
      failure: (error, failures) {},
      expireToken: () {},
      connectionError: () {},
    );
    return loaded;
  }

  Future<bool> _loadAreas() async {
    final result = await _getDiscountableAreasUseCase();
    var loaded = false;
    result.when(
      success: (items, failures, resultCode) {
        loaded = true;
        emit(
          state.copyWith(
            discountableAreas: items
                .where(
                  (item) =>
                      item.id > 0 && item.areaTitle.trim().isNotEmpty,
                )
                .toList(growable: false),
          ),
        );
      },
      failure: (error, failures) {},
      expireToken: () {},
      connectionError: () {},
    );
    return loaded;
  }

  void _emitSubmitError(String message) {
    emit(state.copyWith(isSubmitting: false, errorMessage: message));
  }

  void clearErrorMessage() => emit(state.copyWith(errorMessage: null));
}
