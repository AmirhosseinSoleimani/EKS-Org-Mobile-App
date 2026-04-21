import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_status_history_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/base/cubit/operation_base_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestStatusHistoryCubit
    extends OperationBaseCubit<List<RequestStatusHistoryItemEntity>> {
  final GetRequestStatusHistoryUseCase _getRequestStatusHistoryUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;

  RequestStatusHistoryCubit(
    this._getRequestStatusHistoryUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
  );

  int? requestId;
  int _page = 1;
  final int _pageSize = 3;
  bool _hasMore = true;

  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  List<RequestStatusHistoryItemEntity> items = [];

  /*@override
  Future<void> init() async {
    emitLoading();

    selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      emitError("در دریافت اطلاعات اولیه مشکلی رخ داد.");
      return;
    }

    await _refreshRequestData();

    if ((selectedRequest?.requestStatus ?? 0) > 1) {
      await _fetchEmdadgarInfo();
    }

    await _fetchHistory();
  }*/

  @override
  Future<void> init() async {
    emitLoading();
    await Future.delayed(const Duration(milliseconds: 300));

    _fillMockRequest();
    _fillMockEmdadgarInfo();
    _fillMockHistory();

    emitLoaded();
  }

  void _fillMockRequest() {
    selectedRequest = const ReliefRequestEntity(
      id: 30200,
      trackCode: 87813,
      firstName: "حمیدرضا",
      lastName: "قلی زاده",
      callMobileNumber: "+989120000000",
      chassisNumber: "NAS861110S1175818",
      nationalNumber: "0063787520",
      aidAddress:
      "گیشا، خ. علیایی، بعد از خ. علیرضا کسروی، خ. حسین فرحزادی",
      licensePlate: "34 د 199 77",
      kilometer: 2600,
      carName: "کوئیک S آپشنال",
      carEngineNumber: "I5553056",
      carGroupTitle: "کوئیک",
      carFactoryTitle: "سایپا",

      requestStatus: 7,
      requestStatusTitle: "اتمام کار",

      emMobileNumber1: "09212086820",

      hasEmdadgar: true,
      requestDateTimeJalali: "1404/12/06 08:00",
      insertDateTime: "2026-02-24T15:33:48",
      insertDateTimeJalali: "1404/12/05 15:33",
      serviceType: ServiceType.reliefService,
    );
  }

  void _fillMockEmdadgarInfo() {
    emdadgarInfo = EmdadgarInfoEntity(
      id: 14046,
      startDateText: "1404/02/27",
      endDateText: "1405/12/29",
      shiftTypeText: "امدادرسان",
      shiftTypeId: 2,
      planningId: 51965,
      mobile: "09212086820",
      agencyName: "شهرام محمدي",
      agencyCodeLabel: "H014",
      plakText: "93 ص 356 44",
      khodroTypeText: "سایپا 151",
      shiftName: "شیفت روز خدمات درمحل",
      isActive: true,
    );
  }

  void _fillMockHistory() {
    items = [
      RequestStatusHistoryItemEntity(
        id: 13919242,
        description:
        "درخواست '87813' برای مشتری با نام حمیدرضا قلی زاده ",
        insertUserName: "مدیر سیستم",
        title: "ثبت درخواست",
        insertDateTimeJalali: "1404/12/05",
        insertTime: "15:34:01",
      ),
      RequestStatusHistoryItemEntity(
        id: 13919319,
        description:
        "وضعیت درخواست از در انتظار تایید پیش فاکتور مشتری به رزرو تغییر کرد ",
        insertUserName: "مدیر سیستم",
        title: "تغییر وضعیت درخواست",
        insertDateTimeJalali: "1404/12/09",
        insertTime: "08:17:03",
      ),
      RequestStatusHistoryItemEntity(
        id: 13919320,
        description:
        "امدادگر شهرام محمدي با وضعیت رزرو ثبت گردید",
        insertUserName: "مدیر سیستم",
        title: "اعزام امدادرسان",
        insertDateTimeJalali: "1404/12/09",
        insertTime: "08:17:05",
      ),
    ];

    _hasMore = false; // چون داده ثابت است
  }

  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result =
        selectedRequest!.isHomeService
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

  Future<void> _fetchHistory() async {
    final param = RequestOperationParamEntity(
      requestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      page: 1,
      pageSize: 3,
    );

    final result = await _getRequestStatusHistoryUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items = data.records;
        emitLoaded();
      },
      failure: (error, message) {
        emitError(message ?? 'خطای نامشخص در دریافت تاریخچه');
      },
      connectionError: () {
        emitConnectionError();
      },
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    emitLoadingMore();

    _page++;

    final result = await _getRequestStatusHistoryUseCase(
      RequestOperationParamEntity(
        serviceType: ServiceType.homeService,
        requestId: selectedRequest?.id ?? 0,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data.records.isEmpty) {
          _hasMore = false;
        } else {
          items.addAll(data.records);

          if (items.length < data.count) {
            _hasMore = false;
          }
        }

        emitLoaded();
      },
      failure: (error, msg) {
        _page--;
        emitLoaded();
      },
      connectionError: () {
        _page--;
        emitLoaded();
      },
    );
  }

  bool get hasMore => _hasMore;
}
