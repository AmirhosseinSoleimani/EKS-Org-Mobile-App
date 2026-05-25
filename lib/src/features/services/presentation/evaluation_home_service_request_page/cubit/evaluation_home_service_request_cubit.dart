import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'evaluation_home_service_request_state.dart';
part 'evaluation_home_service_request_cubit.freezed.dart';

@injectable
class EvaluationHomeServiceRequestCubit extends Cubit<EvaluationHomeServiceRequestState> {
  EvaluationHomeServiceRequestCubit() : super(const EvaluationHomeServiceRequestState.idle());


  Future<void> init () async {}
}
