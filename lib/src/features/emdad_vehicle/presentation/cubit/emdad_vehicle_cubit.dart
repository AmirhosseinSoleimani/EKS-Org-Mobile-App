import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'emdad_vehicle_state.dart';
part 'emdad_vehicle_cubit.freezed.dart';

@injectable
class EmdadVehicleCubit extends Cubit<EmdadVehicleState> {
  EmdadVehicleCubit() : super(const EmdadVehicleState.initial());

  VoidCallback? _retryAction;

  bool get hasRetryAction => _retryAction != null;

  void retryLastAction() => _retryAction?.call();
}
