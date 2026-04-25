import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_chassis_request_history_list_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chassis_request_history_cubit.freezed.dart';

part 'chassis_request_history_state.dart';

@injectable
class ChassisRequestHistoryCubit extends Cubit<ChassisRequestHistoryState> {
  final GetChassisRequestHistoryListUseCase
      _getChassisRequestHistoryListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;

  ChassisRequestHistoryCubit(
    this._getChassisRequestHistoryListUseCase,
    this._fetchSelectedRequestItemUseCase,
  ) : super(const ChassisRequestHistoryState.idle());

  BaseRequestEntity? selectedRequest;
  final List<ChassisRequestHistoryEntity> items = [];


  /*void loadFakeData() {
    items.clear();

    items.addAll([
      ChassisRequestHistoryEntity(
        serviceType: ServiceType.reliefService,
        id: 2300309,
        trackingCode: 14376273,
        insertDateTime: "2026-03-10T09:42:58",
        insertDateTimeJalali: "1404/12/19 09:42",
        isSubscription: true,
        subscriptionId: 2002,
        isGauranty: false,
        status: 7,
        statusTitle: "اتمام کار",
        type: 1,
        typeTitle: "خدمات امدادی",
        agencyCode: "5778",
        defectTitle: "استارت - اتصالات استارت",
        service: "حمل",
        mobileNumber: "+989237334527",
        description: "توضیحات درخواست امدادی",
        hamlAzad: true,
        vip: true,
        vipConditionTitle: "VIP",
        chassisNumber: "199821",
        carName: "پراید 111",
      ),
      ChassisRequestHistoryEntity(
        serviceType: ServiceType.homeService,
        id: 998877,
        trackingCode: 55778899,
        insertDateTime: "2026-03-11T15:20:10",
        insertDateTimeJalali: "1404/12/20 15:20",
        isSubscription: false,
        subscriptionId: null,
        isGauranty: true,
        status: 3,
        statusTitle: "در حال رسیدگی",
        type: 2,
        typeTitle: "خدمات در محل",
        agencyCode: "1133",
        defectTitle: "باطری - دشارژ",
        service: "باطری",
        mobileNumber: "+989121112233",
        description: "بازدید خودرو در محل",
        hamlAzad: false,
        vip: false,
        vipConditionTitle: null,
        chassisNumber: "887744",
        carName: "سمند LX",
      ),
      ChassisRequestHistoryEntity(
        id: 665544,
        serviceType: ServiceType.reliefService,
        trackingCode: 22233344,
        insertDateTime: "2026-03-12T18:55:00",
        insertDateTimeJalali: "1404/12/21 18:55",
        isSubscription: false,
        subscriptionId: null,
        isGauranty: false,
        status: 1,
        statusTitle: "در صف بررسی",
        type: 1,
        typeTitle: "حمل ویژه",
        agencyCode: "9922",
        defectTitle: "موتور - داغ کردن",
        service: "یدک‌کش ویژه",
        mobileNumber: "+989305551212",
        description: "داغ کردن موتور در اتوبان",
        hamlAzad: true,
        vip: true,
        vipConditionTitle: "VIP-Plus",
        chassisNumber: "441122",
        carName: "دنا پلاس",
      ),
    ]);

    emit(ChassisRequestHistoryState.loaded());
  }
  Future<void> init() async {
    loadFakeData();
  }
}*/


  Future<void> init() async {
    emit(const ChassisRequestHistoryState.loading());

    selectedRequest  =
        await _fetchSelectedRequestItemUseCase();
    if (selectedRequest == null) {
      _safeEmit(
        const ChassisRequestHistoryState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    await _loadChassisNumberHistoryList();
  }

 Future<void> _loadChassisNumberHistoryList() async {
    items.clear();

    final result = await _getChassisRequestHistoryListUseCase(
      ChassisParamEntity(chassisNumber: selectedRequest?.chassisNumber),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items.addAll(data);
        _safeEmit(const ChassisRequestHistoryState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          ChassisRequestHistoryState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const ChassisRequestHistoryState.connectionError()),
    );
  }

  void _safeEmit(ChassisRequestHistoryState state) {
    if (!isClosed) emit(state);
  }
}
