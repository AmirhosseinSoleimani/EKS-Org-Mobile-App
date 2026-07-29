import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/discountable_area_entity.dart';

const _unset = Object();

class SpecialPlanFormState {
  const SpecialPlanFormState({
    this.products = const [],
    this.discountableAreas = const [],
    this.isLoading = false,
    this.loadFailed = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  final List<SpecialPlanProductEntity> products;
  final List<DiscountableAreaEntity> discountableAreas;
  final bool isLoading;
  final bool loadFailed;
  final bool isSubmitting;
  final String? errorMessage;

  SpecialPlanFormState copyWith({
    List<SpecialPlanProductEntity>? products,
    List<DiscountableAreaEntity>? discountableAreas,
    bool? isLoading,
    bool? loadFailed,
    bool? isSubmitting,
    Object? errorMessage = _unset,
  }) {
    return SpecialPlanFormState(
      products: products ?? this.products,
      discountableAreas: discountableAreas ?? this.discountableAreas,
      isLoading: isLoading ?? this.isLoading,
      loadFailed: loadFailed ?? this.loadFailed,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}
