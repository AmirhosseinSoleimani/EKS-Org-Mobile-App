import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'request_detail_state.dart';
part 'request_detail_cubit.freezed.dart';

@injectable
class RequestDetailCubit extends Cubit<RequestDetailState> {
  RequestDetailCubit() : super(const RequestDetailState.idle());

   BaseRequestEntity selectedRequest = ReliefRequestEntity(
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
  );

  bool get isRelief => selectedRequest is ReliefRequestEntity;


  Future<void> init() async {
    _safeEmit(const RequestDetailState.loaded());

  }

  void _safeEmit(RequestDetailState state) {
    if (!isClosed) emit(state);
  }
}
