import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

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

  void setSelectedStatus(RequestStatus status) {
    _selectedStatusNotifier.value = status;
  }

  void setSelectedTimePeriod(TimePeriod timePeriod) {
    selectedTimePeriodNotifier.value = timePeriod;
  }


  void init(){}


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
}
