import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/add_rescuer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/add_rescuer_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart'
    show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

@injectable
class AddRescuerCubit extends Cubit<AddRescuerState> {
  final List<SimpleDropdownItem<bool>> statusItems = const [
    SimpleDropdownItem<bool>(
      value: true,
      label: 'فعال',
    ),
    SimpleDropdownItem<bool>(
      value: false,
      label: 'غیرفعال',
    ),
  ];
  AddRescuerCubit(this._addRescuerUseCase, this._getProvinceWithCityListUseCase)
      : super(const AddRescuerState());

  final AddRescuerUseCase _addRescuerUseCase;
  final GetProvinceWithCityListUseCase _getProvinceWithCityListUseCase;

  final identityFormKey = GlobalKey<FormState>();
  final contactFormKey = GlobalKey<FormState>();
  final cooperationFormKey = GlobalKey<FormState>();
  final documentsFormKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final nationalNumberController = TextEditingController();
  final birthDateController = TextEditingController();
  final mobileController = TextEditingController();
  final telController = TextEditingController();
  final addressController = TextEditingController();
  final fieldGraduationController = TextEditingController();
  final clothingSizeController = TextEditingController();
  final shoesSizeController = TextEditingController();
  final cooperationStartDateController = TextEditingController();
  final licenseCodeController = TextEditingController();

  List<ProvinceEntity> _cities = const [];
  List<ProvinceEntity> get cities => _cities;

  ProvinceEntity? birthCity;
  ProvinceEntity? issuingCity;
  ProvinceEntity? addressCity;
  int? degree;
  int? marital;
  bool isActive = true;
  String? imageBase64;
  Uint8List? imageBytes;
  String? _birthDateApi;
  String? _cooperationStartDateApi;
  String? _licenseCodeApi;

  Future<void> init() async {
    emit(state.copyWith(
      isLoadingCities: true,
      clearError: true,
      connectionError: false,
    ));
    final result = await _getProvinceWithCityListUseCase();
    result.whenOrNull(
      success: (data, failures, resultCode) {
        _cities = List<ProvinceEntity>.unmodifiable(
          data.where((item) => item.cityId != null),
        );
        emit(state.copyWith(
          isLoadingCities: false,
          connectionError: false,
        ));
      },
      failure: (error, message) => emit(
        state.copyWith(
          isLoadingCities: false,
          errorMessage: message ?? 'دریافت استان و شهر با خطا مواجه شد.',
        ),
      ),
      connectionError: () =>
          emit(state.copyWith(isLoadingCities: false, connectionError: true)),
    );
  }

  void setProfileImage(UploadedFileEntity? file) {
    imageBytes = file?.bytes;
    imageBase64 = file?.dataUri;
    emit(state.copyWith(clearError: true));
  }

  void setBirthDate(Jalali? value) {
    if (value == null) return;
    _birthDateApi = value.toDateTime().toUtc().toIso8601String();
  }

  void setCooperationStartDate(Jalali? value) {
    if (value == null) return;
    final date = value.toDateTime();
    _cooperationStartDateApi =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void setLicenseCodeDate(Jalali? value) {
    if (value == null) return;
    _licenseCodeApi = value.toDateTime().toUtc().toIso8601String();
  }

  void setActive(bool value) {
    isActive = value;
    emit(state.copyWith(isActive: value));
  }

  void setStep(int step) =>
      emit(state.copyWith(currentStep: step, clearError: true));

  void previous() {
    if (state.currentStep > 0) setStep(state.currentStep - 1);
  }

  bool validateCurrent() {
    final keys = [
      identityFormKey,
      contactFormKey,
      cooperationFormKey,
      documentsFormKey,
    ];
    return keys[state.currentStep].currentState?.validate() ?? false;
  }

  void next() {
    if (!validateCurrent()) return;
    if (state.currentStep < 3) setStep(state.currentStep + 1);
  }

  Future<void> submit() async {
    if (!validateCurrent()) return;
    emit(
      state.copyWith(isLoading: true, clearError: true, connectionError: false),
    );

    final param = AddRescuerParamEntity(
      imageBase64: imageBase64,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      fatherName: fatherNameController.text.trim(),
      nationalNumber: nationalNumberController.text.trim(),
      birthDate: _birthDateApi ?? '',
      cityIdPlaceOfBirth: birthCity?.cityId,
      cityIdIssuingPlace: issuingCity?.cityId,
      cityIdAddress: addressCity?.cityId,
      degree: degree,
      fieldGraduation: fieldGraduationController.text.trim(),
      marital: marital,
      address: addressController.text.trim(),
      shoesSize: shoesSizeController.text.trim(),
      clothingSize: clothingSizeController.text.trim(),
      cooperationStartDate: _cooperationStartDateApi ?? '',
      isActive: isActive,
      licenseCode: _licenseCodeApi,
      tel: telController.text.trim(),
      mobile: mobileController.text.trim(),
    );

    final result = await _addRescuerUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) =>
          emit(state.copyWith(isLoading: false, createdId: data.id)),
      failure: (error, message) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage:
              message ?? error?.toString() ?? 'ثبت امدادرسان با خطا مواجه شد.',
        ),
      ),
      connectionError: () =>
          emit(state.copyWith(isLoading: false, connectionError: true)),
    );
  }

  @override
  Future<void> close() {
    for (final controller in [
      firstNameController,
      lastNameController,
      fatherNameController,
      nationalNumberController,
      birthDateController,
      mobileController,
      telController,
      addressController,
      fieldGraduationController,
      clothingSizeController,
      shoesSizeController,
      cooperationStartDateController,
      licenseCodeController,
    ]) {
      controller.dispose();
    }
    return super.close();
  }
}
