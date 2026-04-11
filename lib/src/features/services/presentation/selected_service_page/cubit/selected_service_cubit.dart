import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/abstract/base_request_entity.dart';

part 'selected_service_cubit.freezed.dart';
part 'selected_service_state.dart';

@injectable
class SelectedServiceCubit extends Cubit<SelectedServiceState> {
  SelectedServiceCubit() : super(const SelectedServiceState.idle());

  final ValueNotifier<RequestStatus?> _selectedStatusNotifier =
      ValueNotifier(null);

  ValueNotifier<RequestStatus?> get selectedStatusNotifier =>
      _selectedStatusNotifier;

  RequestStatus? get selectedStatus => _selectedStatusNotifier.value;

  final selectedTimePeriodNotifier = ValueNotifier<TimePeriod>(TimePeriod.all);


  TimePeriod get selectedTimePeriod => selectedTimePeriodNotifier.value;

  final requestNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final chassisNumberController = TextEditingController();
  final rescuerNameController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();

  get requestCount => 200;

  void setSelectedStatus(RequestStatus status) {
    _selectedStatusNotifier.value = status;
  }

  void setSelectedTimePeriod(TimePeriod timePeriod) {
    selectedTimePeriodNotifier.value = timePeriod;
  }


  void init() async{
    emit(const SelectedServiceState.loading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const SelectedServiceState.loaded());
  }


  @override
  Future<void> close() {
    requestNumberController.dispose();
    phoneController.dispose();
    chassisNumberController.dispose();
    rescuerNameController.dispose();
    cityController.dispose();
    provinceController.dispose();
    _selectedStatusNotifier.dispose();
    return super.close();
  }

  List<BaseRequestEntity> buildFakeRequests() {
    return const[
      ReliefRequestEntity(
        id: 1,
        trackCode: 12345,
        firstName: "علی",
        lastName: "رضایی",
        latitude: 35.7,
        longitude: 51.4,
        aidAddress: "تهران، خیابان آزادی",
        cityName: "تهران",
        provinceName: "تهران",
        carName: "پراید 131",
        carProductionYear: 1402,
        licensePlate: "12 الف 345 67",
        requestStatus: 1,
        requestStatusTitle: "در انتظار تخصیص",
        requestDateJalali: "1405/01/17",
        requestTime: "15:30",
        defectId: 1,
        defectTitle: "حمل خودرو",
        isUrgentRequest: false,
        emdadServiceTitle: "حمل خودرو",
      ),
      ReliefRequestEntity(
        id: 2,
        trackCode: 54321,
        firstName: "مهدی",
        lastName: "محمدی",
        latitude: 35.7,
        longitude: 51.4,
        aidAddress: "تهران، پونک",
        cityName: "تهران",
        provinceName: "تهران",
        carName: "کوئیک S",
        carProductionYear: 1404,
        licensePlate: "34 ب 777 11",
        requestStatus: 2,
        requestStatusTitle: "در حال انجام",
        requestDateJalali: "1405/01/18",
        requestTime: "12:00",
        defectId: 2,
        defectTitle: "تعویض باتری",
        isUrgentRequest: true,
        emdadServiceTitle: "تعویض باتری",
      ),
      ReliefRequestEntity(
        id: 3,
        trackCode: 99999,
        firstName: "حسین",
        lastName: "کاظمی",
        latitude: 35.7,
        longitude: 51.4,
        aidAddress: "تهران، صادقیه",
        cityName: "تهران",
        provinceName: "تهران",
        carName: "تیبا",
        carProductionYear: 1401,
        licensePlate: "55 ج 222 88",
        requestStatus: 3,
        requestStatusTitle: "اتمام",
        requestDateJalali: "1405/01/19",
        requestTime: "10:00",
        defectId: 3,
        defectTitle: "حمل خودرو",
        isUrgentRequest: false,
        emdadServiceTitle: "حمل خودرو",
      ),
    ];
  }
}
