import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_control_info_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'control_info_cubit.freezed.dart';
part 'control_info_state.dart';

@injectable
class ControlInfoCubit extends Cubit<ControlInfoState> {
  final GetRequestControlInfoUseCase _getRequestControlInfoUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;

  ControlInfoCubit(
    this._getRequestControlInfoUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
  ) : super(const ControlInfoState.idle());

  EmdadgarInfoEntity? emdadgarInfo;
  BaseRequestEntity? selectedRequest;
  ControlInfoEntity? controlInfoEntity;

  Future<void> init() async {
    _safeEmit(const ControlInfoState.loading());

    selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(
        const ControlInfoState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    await _refreshRequestData();

    if ((selectedRequest?.requestStatus ?? 0) > 1) {
      await _fetchEmdadgarInfo();
    }

    //await loadFakeData();
    await _loadRequestControlInfo();
  }

  Future<void> loadFakeData() async {
    controlInfoEntity = fakeControlInfo();
    emit(const ControlInfoState.loaded());
  }

  ControlInfoEntity fakeControlInfo() {
    final json = {
      "emdadgar": {
        "emdadgarStartedDriving": {
          "id": 2779801,
          "followUpDateTime": "2025-06-30T22:01:00",
          "actionType": 1,
          "authorType": 2,
          "authorId": 47996930,
          "authorFullName": "كامل فكري خواجه",
          "sourceType": 1,
          "resultStatusId": 3,
          "resultStatusTitle": "امدادگر حرکت کرده",
          "description": "ثبت پیگیری توسط موبایل امدادگر كامل فكري خواجه",
          "isDeleted": false,
          "followUpDateJalali": "1404/04/09",
          "followUpTime": "22:01",
          "actionTypeName": "SubmitFollowUp",
          "actionTypeTitle": "ثبت پیگیری",
          "authorTypeName": "Emdadresan",
          "authorTypeTitle": "امدادرسان",
          "sourceTypeName": "Emdadresan",
          "sourceTypeTitle": "امدادرسان",
          "insertDateTime": "0001-01-01T00:00:00",
          "serviceRequestId": 2259853,
          "serviceType": 1
        }
      },
      "systemUser": {
        "emdadgarArrived": {
          "id": 2916062,
          "followUpDateTime": "2025-06-30T22:25:00",
          "actionType": 1,
          "authorType": 1,
          "authorId": 4955,
          "authorFullName": "مدیر سیستم",
          "sourceType": 1,
          "resultStatusId": 1,
          "resultStatusTitle": "رسیده است",
          "isDeleted": false,
          "followUpDateJalali": "1404/04/09",
          "followUpTime": "22:25",
          "actionTypeName": "SubmitFollowUp",
          "actionTypeTitle": "ثبت پیگیری",
          "authorTypeName": "SystemUser",
          "authorTypeTitle": "کاربر سیستم",
          "sourceTypeName": "Emdadresan",
          "sourceTypeTitle": "امدادرسان",
          "insertDateTime": "0001-01-01T00:00:00",
          "serviceRequestId": 2259853,
          "serviceType": 1
        }
      },
      "system": {
        "emdadgarStartedDriving": {
          "id": 2779805,
          "followUpDateTime": "2025-06-30T22:03:03",
          "actionType": 1,
          "authorType": 4,
          "authorId": -100,
          "authorFullName": "سیستم",
          "sourceType": 3,
          "resultStatusId": 3,
          "resultStatusTitle": "امدادگر حرکت کرده",
          "description": "ثبت اتوماتیک پیگیری با توجه به موقعیت امدادگر",
          "isDeleted": false,
          "followUpDateJalali": "1404/04/09",
          "followUpTime": "22:03",
          "actionTypeName": "SubmitFollowUp",
          "actionTypeTitle": "ثبت پیگیری",
          "authorTypeName": "System",
          "authorTypeTitle": "سیستم",
          "sourceTypeName": "AVL",
          "sourceTypeTitle": "AVL",
          "insertDateTime": "0001-01-01T00:00:00",
          "serviceRequestId": 2259853,
          "serviceType": 1
        }
      },
      "serviceRequest": {
        "timeFromCallToBeginRequestRegistration": "00:07:04",
        "timeFromBeginToFinishRequestRegistration": "00:01:34",
        "timeFromFinishRequestRegistrationToAssignEmdadgar": "00:11:40",
        "call": {
          "dateTime": "2025-06-30T21:31:18",
          "authorId": -1,
          "authorFullname": "TelC",
          "time": "21:31:18",
          "dateJalali": "1404/04/09"
        },
        "serviceRequestRegistrationBegin": {
          "dateTime": "2025-06-30T21:38:22",
          "authorId": 48286108,
          "authorFullname": "پیمانکار مرکز تماس تیام 10",
          "time": "21:38:22",
          "dateJalali": "1404/04/09"
        },
        "serviceRequestRegistrationFinish": {
          "dateTime": "2025-06-30T21:39:56",
          "authorId": 48286108,
          "authorFullname": "پیمانکار مرکز تماس تیام 10",
          "time": "21:39:56",
          "dateJalali": "1404/04/09"
        },
        "assignEmdadgar": {
          "dateTime": "2025-06-30T21:51:36",
          "authorId": 48286099,
          "authorFullname": "پیمانکار مرکز تماس تیام 06",
          "time": "21:51:36",
          "dateJalali": "1404/04/09"
        }
      }
    };

    return ControlInfoModel.fromJson(json);
  }


  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = selectedRequest!.isHomeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, __) {
        selectedRequest = data;
      },
    );
  }

  Future<void> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );

    final result = await _getEmdadgarInfoUseCase(param);

    result.whenOrNull(
      success: (data, _, __) {
        emdadgarInfo = data;
      },
    );
  }

  Future<void> _loadRequestControlInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );
    final result = await _getRequestControlInfoUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        controlInfoEntity = data;

        _safeEmit(const ControlInfoState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          ControlInfoState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const ControlInfoState.connectionError()),
    );
  }

  void _safeEmit(ControlInfoState state) {
    if (!isClosed) emit(state);
  }
}
