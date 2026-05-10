
import 'package:eks_sana_plus_org/src/common/constants/gender.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/car_covers_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/complete_urgent_request_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/complete_aid_urgent_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_basic_data_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_minimal_customer_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_reference_car_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'complete_urgent_request_state.dart';
part 'complete_urgent_request_cubit.freezed.dart';

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

  final TextEditingController chassisNumberController = TextEditingController();
  final TextEditingController engineNumberController = TextEditingController();
  final TextEditingController buildYearController = TextEditingController();
  final TextEditingController kilometerController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();
  final TextEditingController nationalCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController familyNameController = TextEditingController();

  Future<void> setSelectedCoverCar(CoverCarEntity value) async {
    selectedCoverCars.value = value;
  }
  Future<void> setSelectedColorCar(CarColorEntity value) async {
    selectedColorCar.value = value;
  }

  Future<void> init() async{}

  Future<void> submit() async{}

  Future<void> getReferenceCar() async{}

  Future<void> getUserInfo() async{}
}
