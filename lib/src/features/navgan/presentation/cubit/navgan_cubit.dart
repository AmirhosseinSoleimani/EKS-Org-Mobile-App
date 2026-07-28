import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_grade_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/add_navgan_grade_reference_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/delete_navgan_grade_reference_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/get_grade_pattern_detail_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/get_grade_pattern_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/get_navgan_defects_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/get_navgan_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/get_navgan_service_groups_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/submit_navgan_defects_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/usecases/submit_navgan_service_categories_use_case.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavganCubit extends Cubit<NavganState> {
  NavganCubit(
    this._getListUseCase,
    this._getGradePatternsUseCase,
    this._getGradePatternDetailUseCase,
    this._addGradeReferenceUseCase,
    this._deleteGradeReferenceUseCase,
    this._getServiceGroupsUseCase,
    GetNavganDefectsUseCase _,
    this._submitServiceCategoriesUseCase,
    SubmitNavganDefectsUseCase __,
  ) : super(const NavganState());

  final GetNavganListUseCase _getListUseCase;
  final GetGradePatternListUseCase _getGradePatternsUseCase;
  final GetGradePatternDetailUseCase _getGradePatternDetailUseCase;
  final AddNavganGradeReferenceUseCase _addGradeReferenceUseCase;
  final DeleteNavganGradeReferenceUseCase _deleteGradeReferenceUseCase;
  final GetNavganServiceGroupsUseCase _getServiceGroupsUseCase;
  final SubmitNavganServiceCategoriesUseCase _submitServiceCategoriesUseCase;

  Future<void> init() async {
    await fetchList();
  }

  Future<void> fetchList() async {
    if (state.isInitialLoading) return;

    emit(state.copyWith(
      status: NavganViewStatus.loading,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    final result = await _getListUseCase();
    result.when(
      success: (page, failures, resultCode) {
        emit(state.copyWith(
          status: page.records.isEmpty
              ? NavganViewStatus.empty
              : NavganViewStatus.loaded,
          records: page.records,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: NavganViewStatus.failure,
        errorMessage: failures ?? 'دریافت لیست ناوگان با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: NavganViewStatus.failure,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: NavganViewStatus.connectionError,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<void> prepareGradeSheet(NavganEntity navgan) async {
    emit(state.copyWith(
      selectedNavgan: navgan,
      clearSelectedGradePattern: true,
      clearGradePatternDetail: true,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));
    await fetchGradePatterns();
  }

  Future<void> fetchGradePatterns() async {
    if (state.isGradePatternsLoading) return;

    emit(state.copyWith(isGradePatternsLoading: true));
    final result = await _getGradePatternsUseCase();
    result.when(
      success: (items, failures, resultCode) => emit(state.copyWith(
        gradePatterns: items,
        isGradePatternsLoading: false,
        clearErrorMessage: true,
      )),
      failure: (error, failures) => emit(state.copyWith(
        isGradePatternsLoading: false,
        errorMessage: failures ?? 'دریافت الگوی گرید با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isGradePatternsLoading: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isGradePatternsLoading: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<void> selectGradePattern(GradePatternEntity? value) async {
    emit(state.copyWith(
      selectedGradePattern: value,
      clearGradePatternDetail: true,
    ));

    final id = value?.id ?? value?.gradeId;
    if (id == null) return;
    await fetchGradePatternDetail(id);
  }

  Future<void> fetchGradePatternDetail(int id) async {
    if (state.isGradeDetailLoading) return;

    emit(state.copyWith(isGradeDetailLoading: true));
    final result = await _getGradePatternDetailUseCase(
      NavganIdParamEntity(id: id),
    );
    result.when(
      success: (item, failures, resultCode) => emit(state.copyWith(
        gradePatternDetail: item,
        isGradeDetailLoading: false,
        clearErrorMessage: true,
      )),
      failure: (error, failures) => emit(state.copyWith(
        isGradeDetailLoading: false,
        errorMessage: failures ?? 'دریافت جزئیات الگوی گرید با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isGradeDetailLoading: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isGradeDetailLoading: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<void> loadGradePatternDetail(GradePatternEntity pattern) async {
    emit(state.copyWith(
      selectedGradePattern: pattern,
      clearGradePatternDetail: true,
    ));
    final id = pattern.id ?? pattern.gradeId;
    if (id == null) return;
    await fetchGradePatternDetail(id);
  }

  Future<bool> submitGradeReference() async {
    if (state.isGradeSubmitting) return false;
    final navgan = state.selectedNavgan;
    final pattern = state.selectedGradePattern;
    final navganId = navgan?.id;
    final patternId = pattern?.id ?? pattern?.gradeId;
    if (navganId == null || patternId == null) {
      emit(state.copyWith(errorMessage: 'الگوی گرید را انتخاب کنید.'));
      return false;
    }

    emit(state.copyWith(isGradeSubmitting: true, clearErrorMessage: true));
    final result = await _addGradeReferenceUseCase(
      NavganGradeReferenceParamEntity(
        gradePatternId: patternId,
        serviceTypeId: navgan?.emdadgarNavganType ?? 1,
        refType: 1,
        refId: navganId,
      ),
    );

    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isGradeSubmitting: false,
          successMessage: 'الگوی گرید با موفقیت ثبت شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isGradeSubmitting: false,
        errorMessage: failures ?? 'ثبت الگوی گرید با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isGradeSubmitting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isGradeSubmitting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    return success;
  }

  Future<bool> assignGradePattern(GradePatternEntity pattern) async {
    emit(state.copyWith(selectedGradePattern: pattern));
    return submitGradeReference();
  }

  Future<bool> deleteGradeReference(int referenceId) async {
    if (state.isGradeDeleting) return false;

    emit(state.copyWith(isGradeDeleting: true, clearErrorMessage: true));
    final result = await _deleteGradeReferenceUseCase(
      NavganIdParamEntity(id: referenceId),
    );

    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isGradeDeleting: false,
          successMessage: 'الگوی گرید با موفقیت حذف شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isGradeDeleting: false,
        errorMessage: failures ?? 'حذف الگوی گرید با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isGradeDeleting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isGradeDeleting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    return success;
  }

  Future<void> prepareServiceSheet(NavganEntity navgan) async {
    emit(state.copyWith(
      selectedNavgan: navgan,
      serviceGroups: const [],
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));
    await fetchServiceGroups(navgan);
  }

  Future<void> fetchServiceGroups(NavganEntity navgan) async {
    final id = navgan.id;
    if (id == null || state.isServiceGroupsLoading) return;

    emit(state.copyWith(isServiceGroupsLoading: true));
    final result = await _getServiceGroupsUseCase(NavganIdParamEntity(id: id));
    result.when(
      success: (items, failures, resultCode) => emit(state.copyWith(
        serviceGroups: items,
        isServiceGroupsLoading: false,
        clearErrorMessage: true,
      )),
      failure: (error, failures) => emit(state.copyWith(
        isServiceGroupsLoading: false,
        errorMessage: failures ?? 'دریافت سرویس‌ها با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isServiceGroupsLoading: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isServiceGroupsLoading: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  void toggleServiceCategory(EmdadServiceCategoryEntity category) {
    final groups = state.serviceGroups.map((group) {
      final categories = group.emdadCategories.map((item) {
        if (item.id != category.id) return item;
        return item.copyWith(selected: !item.selected);
      }).toList();
      return group.copyWith(emdadCategories: categories);
    }).toList();
    emit(state.copyWith(serviceGroups: groups));
  }

  Future<bool> submitServiceCategories() async {
    if (state.isServicesSubmitting) return false;
    final navganId = state.selectedNavgan?.id;
    if (navganId == null) return false;

    final ids = state.serviceGroups
        .expand((group) => group.emdadCategories)
        .where((item) => item.selected && item.id != null)
        .map((item) => item.id!)
        .toList();

    emit(state.copyWith(isServicesSubmitting: true, clearErrorMessage: true));
    final result = await _submitServiceCategoriesUseCase(
      NavganIdsPayloadParamEntity(navganId: navganId, ids: ids),
    );

    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isServicesSubmitting: false,
          successMessage: 'سرویس‌های ناوگان با موفقیت ثبت شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isServicesSubmitting: false,
        errorMessage: failures ?? 'ثبت سرویس‌ها با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isServicesSubmitting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isServicesSubmitting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    return success;
  }
}
