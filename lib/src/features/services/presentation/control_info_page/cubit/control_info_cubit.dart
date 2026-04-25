import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'control_info_state.dart';
part 'control_info_cubit.freezed.dart';

class ControlInfoCubit extends Cubit<ControlInfoState> {
  ControlInfoCubit() : super(const ControlInfoState.initial());
}
