import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/gender.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/car_covers_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/complete_urgent_request_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/complete_urgent_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_reference_car_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/minimal_customer_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/complete_aid_urgent_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_basic_data_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_minimal_customer_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_reference_car_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'complete_urgent_request_cubit.freezed.dart';

part 'complete_urgent_request_state.dart';

@injectable
class CompleteUrgentRequestCubit extends Cubit<CompleteUrgentRequestState> {
  CompleteUrgentRequestCubit(
      this._fetchSelectedRequestItemUseCase,
      this._getBasicDataUseCase,
      this._getReferenceCarUseCase,
      this._getMinimalCustomerInfoUseCase,
      this._completeAidUrgentRequestUseCase,
      ) : super(const CompleteUrgentRequestState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetBasicDataUseCase _getBasicDataUseCase;
  final GetReferenceCarUseCase _getReferenceCarUseCase;
  final GetMinimalCustomerInfoUseCase _getMinimalCustomerInfoUseCase;
  final CompleteAidUrgentRequestUseCase _completeAidUrgentRequestUseCase;

  BaseRequestEntity? selectedRequest;
  CarCoversDataEntity? baseData;

  final selectedCoverCars = ValueNotifier<CoverCarEntity?>(null);
  final selectedColorCar = ValueNotifier<CarColorEntity?>(null);
  final genderNotifier = ValueNotifier<Gender?>(null);

  final isGettingReferenceCar = ValueNotifier(false);
  final isGettingCustomerInfo = ValueNotifier(false);

  final chassisNumberController = TextEditingController();
  final engineNumberController = TextEditingController();
  final buildYearController = TextEditingController();
  final kilometerController = TextEditingController();
  final licensePlateController = TextEditingController();
  final nationalCodeController = TextEditingController();
  final nameController = TextEditingController();
  final familyNameController = TextEditingController();

  String? _errorMessage;

  Future<void> setSelectedCoverCar(CoverCarEntity value) async {
    selectedCoverCars.value = value;
  }

  Future<void> setSelectedColorCar(CarColorEntity value) async {
    selectedColorCar.value = value;
  }

  Future<void> init() async {
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const CompleteUrgentRequestState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const CompleteUrgentRequestState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();
    if (selectedResult != FetchResultType.success) return selectedResult;

    _safeEmit(const CompleteUrgentRequestState.loading());

    final basicDataResult = await _fetchBasicData();
    if (basicDataResult != FetchResultType.success) return basicDataResult;

    _setInitialValues();
    return FetchResultType.success;
  }

  Future<FetchResultType> _fetchSelectedRequest() async {
    try {
      selectedRequest =
      await _fetchSelectedRequestItemUseCase.call() as BaseRequestEntity;

      final plate = selectedRequest?.licensePlate;
      if (plate?.isNotEmpty == true) {
        licensePlateController.text = plate!;
      }

      return FetchResultType.success;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchBasicData() async {
    final result = await _getBasicDataUseCase();
    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, _) {
        baseData = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () => fetchResult = FetchResultType.connectionError,
      expireToken: () => fetchResult = FetchResultType.expireToken,
    );

    return fetchResult;
  }

  void _setInitialValues() {
    final carName = selectedRequest?.carName;
    final carColorTitle = selectedRequest?.carColorTitle;

    if (carName != null) {
      selectedCoverCars.value = baseData?.coverCars
          ?.where((e) => e.name == carName)
          .firstOrNull;
    }

    if (carColorTitle != null) {
      selectedColorCar.value = baseData?.carColors
          ?.where((e) => e.colorName == carColorTitle)
          .firstOrNull;
    }
  }

  Future<void> getReferenceCar() async {
    final chassis = chassisNumberController.text.trim();
    if (chassis.isEmpty) {
      _emitError('شماره شاسی را وارد کنید');
      return;
    }

    isGettingReferenceCar.value = true;

    final result = await _getReferenceCarUseCase(
      GetReferenceCarParamEntity(chassisNo: chassis),
    );

    result.whenOrNull(
      success: (car, _, _) async {
        chassisNumberController.text = car.chassisNo ?? '';
        engineNumberController.text = car.engineNumber ?? '';
        buildYearController.text = car.productionYear?.toString() ?? '';
        licensePlateController.text = car.licensePlateNo ?? '';

        final carModel = baseData?.coverCars
            ?.where((e) => e.id == car.carModelId)
            .firstOrNull;
        if (carModel != null) await setSelectedCoverCar(carModel);

        final color = baseData?.carColors
            ?.where((e) => e.colorId == car.color)
            .firstOrNull;
        if (color != null) await setSelectedColorCar(color);
      },
      failure: (_, msg) => _emitError(_fallbackError(msg)),
      connectionError: () =>
          _safeEmit(const CompleteUrgentRequestState.connectionError()),
    );

    isGettingReferenceCar.value = false;
  }

  Future<void> getUserInfo() async {
    final nationalCode = nationalCodeController.text.trim();
    if (nationalCode.isEmpty) {
      _emitError('کد ملی را وارد کنید');
      return;
    }

    isGettingCustomerInfo.value = true;

    final result = await _getMinimalCustomerInfoUseCase(
      MinimalCustomerInfoParamEntity(nationalNo: nationalCode),
    );

    result.whenOrNull(
      success: (user, _, _) {
        nameController.text = user.firstName;
        familyNameController.text = user.lastName;
        nationalCodeController.text = user.nationalNo;
        genderNotifier.value = Gender.fromValue(user.gender);
      },
      failure: (_, msg) => _emitError(_fallbackError(msg)),
      connectionError: () =>
          _safeEmit(const CompleteUrgentRequestState.connectionError()),
    );

    isGettingCustomerInfo.value = false;
  }

  Future<void> submit() async {
    _safeEmit(const CompleteUrgentRequestState.submitLoading());

    final param = CompleteUrgentParamEntity(
      serviceRequestId: selectedRequest?.id,
      nationalCode: nationalCodeController.text.trim(),
      firstName: nameController.text.trim(),
      lastName: familyNameController.text.trim(),
      gender: genderNotifier.value?.value,
      carModelId: selectedCoverCars.value?.id,
      carName: selectedCoverCars.value?.name,
      carColor: selectedColorCar.value?.colorId,
      carProductionYear: buildYearController.text.trim(),
      chassisNo: chassisNumberController.text.trim(),
      engineNumber: engineNumberController.text.trim(),
      customerKilometer: kilometerController.text.trim(),
      licensePlate: licensePlateController.text.trim(),
    );

    final result = await _completeAidUrgentRequestUseCase(param);

    result.whenOrNull(
      success: (data, _, _) =>
          _safeEmit(CompleteUrgentRequestState.submitSuccess(data: data)),
      failure: (_, msg) => _emitError(_fallbackError(msg)),
      connectionError: () =>
          _safeEmit(const CompleteUrgentRequestState.connectionError()),
    );
  }

  void _safeEmit(CompleteUrgentRequestState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      CompleteUrgentRequestState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  String _fallbackError([String? msg]) {
    if (msg?.trim().isNotEmpty == true) return msg!;
    return 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }
}

