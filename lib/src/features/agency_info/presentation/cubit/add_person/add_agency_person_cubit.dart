import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_person_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/person_info_search_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_person_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/search_person_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

@injectable
class AddAgencyPersonCubit extends Cubit<AddAgencyPersonState> {
  AddAgencyPersonCubit(
    this._searchPersonInfoUseCase,
    this._addAgencyPersonUseCase,
  ) : super(const AddAgencyPersonState()) {
    searchController.addListener(_keepSearchSingleLine);
  }

  final SearchPersonInfoUseCase _searchPersonInfoUseCase;
  final AddAgencyPersonUseCase _addAgencyPersonUseCase;

  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final contractStartDateController = TextEditingController();
  final contractEndDateController = TextEditingController();
  final aidPersonMobileController = TextEditingController();
  final jobPositionController = TextEditingController();
  final descriptionController = TextEditingController();

  String? contractStartDateApi;
  String? contractEndDateApi;

  void _keepSearchSingleLine() {
    final text = searchController.text;
    if (!text.contains('\n')) return;

    final normalized = text.replaceAll('\n', ' ').trimLeft();
    searchController.value = TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  Future<void> search() async {
    final query = searchController.text.trim();
    if (query.isEmpty || state.isSearching) return;

    emit(state.copyWith(
      status: AddAgencyPersonStatus.searching,
      clearErrorMessage: true,
    ));

    final result = await _searchPersonInfoUseCase(
      PersonInfoSearchParamEntity(searchValue: query),
    );

    result.when(
      success: (data, failures, resultCode) {
        final records = data.records ?? const <PersonInfoSearchEntity>[];
        emit(state.copyWith(
          status: records.isEmpty
              ? AddAgencyPersonStatus.searchEmpty
              : AddAgencyPersonStatus.searchLoaded,
          persons: records,
          searchCount: (data.count ?? 0) > 0 ? data.count! : records.length,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: AddAgencyPersonStatus.failure,
        errorMessage: failures ?? 'جستجوی امدادرسان با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: AddAgencyPersonStatus.failure,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: AddAgencyPersonStatus.connectionError,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  void selectPerson(PersonInfoSearchEntity person) {
    emit(state.copyWith(
      selectedPerson: person,
      clearErrorMessage: true,
    ));
  }

  void setContractStartDate(Jalali? value) {
    if (value == null) return;
    contractStartDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setContractEndDate(Jalali? value) {
    if (value == null) return;
    contractEndDateApi = JalaliDateHelper.formatServerDateOnly(value.toDateTime());
  }

  void setIssuanceOnIdCard(bool value) {
    emit(state.copyWith(issuanceOnIdCard: value, clearErrorMessage: true));
  }

  void setIsActive(bool value) {
    emit(state.copyWith(isActive: value, clearErrorMessage: true));
  }

  void setActivityType(String value) {
    emit(state.copyWith(activityType: value, clearErrorMessage: true));
  }

  Future<void> submit(AgencyInfoEntity agency) async {
    if (state.isSubmitting) return;

    final agencyId = agency.id;
    final personId = state.selectedPerson?.id;
    if (agencyId == null || personId == null) {
      emit(state.copyWith(
        status: AddAgencyPersonStatus.failure,
        errorMessage: 'شناسه نمایندگی یا امدادرسان معتبر نیست.',
      ));
      return;
    }

    if (formKey.currentState?.validate() != true) return;

    emit(state.copyWith(
      status: AddAgencyPersonStatus.submitting,
      clearErrorMessage: true,
    ));

    final result = await _addAgencyPersonUseCase(
      AddAgencyPersonParamEntity(
        agencyInfoId: agencyId,
        personInfoId: personId,
        contractStartDate: contractStartDateApi ?? '',
        contractEndDate: contractEndDateApi,
        aidPersonMobile: _emptyToNull(aidPersonMobileController.text),
        jobPosition: jobPositionController.text.trim(),
        issuanceOnIdCard: state.issuanceOnIdCard,
        description: _emptyToNull(descriptionController.text),
        activityType: state.activityType,
        isActive: state.isActive,
      ),
    );

    result.when(
      success: (data, failures, resultCode) {
        emit(state.copyWith(
          status: AddAgencyPersonStatus.submitSuccess,
          createdId: data.id,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: AddAgencyPersonStatus.failure,
        errorMessage: failures ?? 'ثبت امدادرسان با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: AddAgencyPersonStatus.failure,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: AddAgencyPersonStatus.connectionError,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  String? validateRequired(String? value) {
    return value?.trim().isNotEmpty == true ? null : 'این فیلد اجباری است';
  }

  String? validateMobile(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    return RegExp(r'^09\d{9}$').hasMatch(trimmed)
        ? null
        : 'شماره موبایل معتبر نیست. لطفا دوباره وارد کنید.';
  }

  @override
  Future<void> close() {
    searchController.removeListener(_keepSearchSingleLine);
    searchController.dispose();
    contractStartDateController.dispose();
    contractEndDateController.dispose();
    aidPersonMobileController.dispose();
    jobPositionController.dispose();
    descriptionController.dispose();
    return super.close();
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
