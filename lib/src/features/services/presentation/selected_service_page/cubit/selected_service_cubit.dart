import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'selected_service_state.dart';
part 'selected_service_cubit.freezed.dart';

@injectable
class SelectedServiceCubit extends Cubit<SelectedServiceState> {
  SelectedServiceCubit() : super(const SelectedServiceState.idle());

  void init(){}
}
