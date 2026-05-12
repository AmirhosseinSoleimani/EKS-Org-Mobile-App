import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_home_service_request_time_state.dart';
part 'change_home_service_request_time_cubit.freezed.dart';

class ChangeHomeServiceRequestTimeCubit extends Cubit<ChangeHomeServiceRequestTimeState> {
  ChangeHomeServiceRequestTimeCubit() : super(const ChangeHomeServiceRequestTimeState.initial());
}
