import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../domain/entities/abstract/base_request_entity.dart';

part 'request_list_cubit.freezed.dart';

part 'home_service_request_list_state.dart';

@injectable
class HomeServiceRequestListCubit extends Cubit<HomeServiceRequestListState> {
  HomeServiceRequestListCubit(this._getHomeServiceRequestListUseCase)
      : super(const HomeServiceRequestListState.idle());

  final GetHomeServiceRequestListUseCase _getHomeServiceRequestListUseCase;

  final List<BaseRequestEntity> requestList = <BaseRequestEntity>[];

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

  void init() async {
    _safeEmit(const HomeServiceRequestListState.loading());

    /*final param = ReportParamEntity(
      serviceType: selectedServiceType,
      fromDateTime: selectedFromDate,
      toDateTime: selectedToDate,
    );*/

    final result = await _getHomeServiceRequestListUseCase();

    result.whenOrNull(
      success: (data, failures, resultCode) async {
        requestList.clear();
        requestList.addAll(data);
        _safeEmit(const HomeServiceRequestListState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          HomeServiceRequestListState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const HomeServiceRequestListState.connectionError()),
    );
  }

  void _safeEmit(HomeServiceRequestListState state) {
    if (!isClosed) emit(state);
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
      HomeServiceRequestEntity(
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
        agencyCode: '12',
        agencyName: 'test',
        bookedDateTimeJalali:"1405/01/17",
        emdadgarName: 'milad',
        emdadServiceCategoryTitle: 'test cat',
        requestDay: '1',
      ),
    ];
  }
}
