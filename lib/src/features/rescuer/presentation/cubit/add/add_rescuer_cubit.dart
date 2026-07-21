import 'dart:convert';
import 'dart:typed_data';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/add_rescuer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/add_rescuer_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart' show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddRescuerCubit extends Cubit<AddRescuerState> {
  AddRescuerCubit(this._addRescuerUseCase, this._getProvinceWithCityListUseCase) : super(const AddRescuerState());
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
  final issuingPlaceController = TextEditingController();
  final addressController = TextEditingController();
  final degreeController = TextEditingController();
  final fieldGraduationController = TextEditingController();
  final clothingSizeController = TextEditingController();
  final shoesSizeController = TextEditingController();
  final cooperationStartDateController = TextEditingController();
  final licenseCodeController = TextEditingController();

  List<ProvinceEntity> locations = const [];
  int? birthCityId, issuingCityId, addressCityId, degree, marital;
  bool isActive = true;
  String? imageBase64;

  Future<void> init() async {
    emit(state.copyWith(isLoadingCities: true, clearError: true));
    final result = await _getProvinceWithCityListUseCase();
    result.whenOrNull(
      success: (data, failures, resultCode) { locations = data; emit(state.copyWith(isLoadingCities: false)); },
      failure: (error, message) => emit(state.copyWith(isLoadingCities: false, errorMessage: message ?? 'دریافت استان و شهر با خطا مواجه شد.')),
      connectionError: () => emit(state.copyWith(isLoadingCities: false, connectionError: true)),
    );
  }

  List<ProvinceEntity> get cities => locations.where((e) => e.cityId != null).toList(growable: false);
  void setImage(Uint8List bytes, String mime) { imageBase64 = 'data:$mime;base64,${base64Encode(bytes)}'; emit(state.copyWith(clearError: true)); }
  void setStep(int step) => emit(state.copyWith(currentStep: step, clearError: true));
  void previous() { if (state.currentStep > 0) setStep(state.currentStep - 1); }
  bool validateCurrent() {
    final keys = [identityFormKey, contactFormKey, cooperationFormKey, documentsFormKey];
    return keys[state.currentStep].currentState?.validate() ?? false;
  }
  void next() { if (!validateCurrent()) return; if (state.currentStep < 3) setStep(state.currentStep + 1); }

  Future<void> submit() async {
    if (!validateCurrent()) return;
    emit(state.copyWith(isLoading: true, clearError: true, connectionError: false));
    final param = AddRescuerParamEntity(
      imageBase64: imageBase64, firstName: firstNameController.text.trim(), lastName: lastNameController.text.trim(), fatherName: fatherNameController.text.trim(), nationalNumber: nationalNumberController.text.trim(), birthDate: birthDateController.text.trim(), cityIdPlaceOfBirth: birthCityId, cityIdIssuingPlace: issuingCityId, cityIdAddress: addressCityId, degree: degree, fieldGraduation: fieldGraduationController.text.trim(), marital: marital, address: addressController.text.trim(), shoesSize: shoesSizeController.text.trim(), clothingSize: clothingSizeController.text.trim(), cooperationStartDate: cooperationStartDateController.text.trim(), isActive: isActive, licenseCode: licenseCodeController.text.trim(), tel: telController.text.trim(), mobile: mobileController.text.trim(),
    );
    final result = await _addRescuerUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) => emit(state.copyWith(isLoading: false, createdId: data.id)),
      failure: (error, message) => emit(state.copyWith(isLoading: false, errorMessage: message ?? error?.toString() ?? 'ثبت امدادرسان با خطا مواجه شد.')),
      connectionError: () => emit(state.copyWith(isLoading: false, connectionError: true)),
    );
  }

  @override Future<void> close() { for (final c in [firstNameController,lastNameController,fatherNameController,nationalNumberController,birthDateController,mobileController,telController,issuingPlaceController,addressController,degreeController,fieldGraduationController,clothingSizeController,shoesSizeController,cooperationStartDateController,licenseCodeController]) { c.dispose(); } return super.close(); }
}
