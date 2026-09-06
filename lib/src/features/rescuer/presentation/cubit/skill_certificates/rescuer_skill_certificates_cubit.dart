import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/submit_skill_certificates_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuer_skill_certificates_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/submit_rescuer_skill_certificates_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/skill_certificates/rescuer_skill_certificates_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart'
    show ApiResultPatterns;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RescuerSkillCertificatesCubit
    extends Cubit<RescuerSkillCertificatesState> {
  final GetRescuerSkillCertificatesUseCase _getSkillCertificatesUseCase;
  final SubmitRescuerSkillCertificatesUseCase
      _submitSkillCertificatesUseCase;

  RescuerSkillCertificatesCubit(
    this._getSkillCertificatesUseCase,
    this._submitSkillCertificatesUseCase,
  ) : super(const RescuerSkillCertificatesState());

  final searchController = TextEditingController();

  Future<void> load(int personInfoId) async {
    if (state.isLoading) return;

    _safeEmit(
      state.copyWith(
        status: RescuerSkillCertificatesStatus.loading,
        message: null,
      ),
    );

    final result = await _getSkillCertificatesUseCase(personInfoId);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        final items = List<SkillCertificateEntity>.unmodifiable(data);
        _safeEmit(
          state.copyWith(
            status: RescuerSkillCertificatesStatus.loaded,
            items: items,
            filteredItems: _filter(items, state.searchText),
            message: null,
          ),
        );
      },
      failure: (error, message) {
        _safeEmit(
          state.copyWith(
            status: RescuerSkillCertificatesStatus.failure,
            message:
                message ??
                error?.toString() ??
                'دریافت گواهینامه‌های مهارت با خطا مواجه شد.',
          ),
        );
      },
      connectionError: () {
        _safeEmit(
          state.copyWith(
            status: RescuerSkillCertificatesStatus.connectionError,
            message: 'اتصال اینترنت خود را بررسی کنید.',
          ),
        );
      },
    );
  }

  void onSearchChanged(String value) {
    if (state.isSubmitting) return;

    _safeEmit(
      state.copyWith(
        status: RescuerSkillCertificatesStatus.loaded,
        searchText: value,
        filteredItems: _filter(state.items, value),
        message: null,
      ),
    );
  }

  void toggleCertificate(int id) {
    if (state.isSubmitting) return;

    final items = state.items.map((item) {
      if (item.id != id) return item;
      return item.copyWith(selectable: item.selectable != true);
    }).toList(growable: false);

    _safeEmit(
      state.copyWith(
        status: RescuerSkillCertificatesStatus.loaded,
        items: List<SkillCertificateEntity>.unmodifiable(items),
        filteredItems: _filter(items, state.searchText),
        message: null,
      ),
    );
  }

  void setAll(bool selected) {
    if (state.isSubmitting) return;

    final items = state.items
        .map(
          (item) => item.id == null
              ? item
              : item.copyWith(selectable: selected),
        )
        .toList(growable: false);

    _safeEmit(
      state.copyWith(
        status: RescuerSkillCertificatesStatus.loaded,
        items: List<SkillCertificateEntity>.unmodifiable(items),
        filteredItems: _filter(items, state.searchText),
        message: null,
      ),
    );
  }

  Future<void> submit(int personInfoId) async {
    if (state.isSubmitting) return;

    _safeEmit(
      state.copyWith(
        status: RescuerSkillCertificatesStatus.submitting,
        message: null,
      ),
    );

    final selectedIds = state.items
        .where((item) => item.selectable == true && item.id != null)
        .map((item) => item.id!)
        .toList(growable: false);

    final result = await _submitSkillCertificatesUseCase(
      SubmitSkillCertificatesParamEntity(
        skillCertificateIds: selectedIds,
        personInfoId: personInfoId,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        _safeEmit(
          state.copyWith(
            status: RescuerSkillCertificatesStatus.success,
            message: data.message,
          ),
        );
      },
      failure: (error, message) {
        _safeEmit(
          state.copyWith(
            status: RescuerSkillCertificatesStatus.failure,
            message:
                message ??
                error?.toString() ??
                'ثبت گواهینامه‌های مهارت با خطا مواجه شد.',
          ),
        );
      },
      connectionError: () {
        _safeEmit(
          state.copyWith(
            status: RescuerSkillCertificatesStatus.connectionError,
            message: 'اتصال اینترنت خود را بررسی کنید.',
          ),
        );
      },
    );
  }

  List<SkillCertificateEntity> _filter(
    List<SkillCertificateEntity> items,
    String query,
  ) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return List.unmodifiable(items);

    return List<SkillCertificateEntity>.unmodifiable(
      items.where((item) {
        return (item.title ?? '').toLowerCase().contains(normalizedQuery);
      }),
    );
  }


  void _safeEmit(RescuerSkillCertificatesState nextState) {
    if (!isClosed) emit(nextState);
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
