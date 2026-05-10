import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_urgent_request_state.dart';
part 'complete_urgent_request_cubit.freezed.dart';

class CompleteUrgentRequestCubit extends Cubit<CompleteUrgentRequestState> {

  CompleteUrgentRequestCubit() : super(const CompleteUrgentRequestState.idle());
}
