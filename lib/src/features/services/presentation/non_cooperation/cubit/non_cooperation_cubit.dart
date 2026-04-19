import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/non_cooperation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_non_cooperation_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'non_cooperation_cubit.freezed.dart';
part 'non_cooperation_state.dart';

@injectable
class NonCooperationCubit extends Cubit<NonCooperationState> {
  final GetNonCooperationListUseCase _getNonCooperationListUseCase;

  NonCooperationCubit(this._getNonCooperationListUseCase)
      : super(const NonCooperationState.idle());

  NonCooperationListEntity? _listEntity;
  BaseRequestEntity? selectedRequest;
  final List<NonCooperationItemEntity> items = [];

  int _page = 1;
  final int _pageSize = 3;

  bool _hasMore = true;

  Future<void> init() async {
    emit(const NonCooperationState.loading());

    _page = 1;
    _hasMore = true;
    items.clear();

    final result = await _getNonCooperationListUseCase(
      NonCooperationParamEntity(
        serviceType: ServiceType.homeService,
        requestId: 2300350,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data != null) {
          items.addAll(data.records);

          if (data.records.length < _pageSize) {
            _hasMore = false;
          }
        }

        _safeEmit(const NonCooperationState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          NonCooperationState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const NonCooperationState.connectionError()),
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    emit(const NonCooperationState.loadingMore());

    _page++;

    final result = await _getNonCooperationListUseCase(
      NonCooperationParamEntity(
        serviceType: ServiceType.homeService,
        requestId: 2300350,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data != null) {
          if (data.records.isEmpty) {
            _hasMore = false;
          } else {
            items.addAll(data.records);

            if (data.records.length < _pageSize) {
              _hasMore = false;
            }
          }
        }

        _safeEmit(const NonCooperationState.loaded());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(const NonCooperationState.loaded());
      },
      connectionError: () {
        _page--;
        _safeEmit(const NonCooperationState.loaded());
      },
    );
  }

  bool get hasMore => _hasMore;

  void _safeEmit(NonCooperationState state) {
    if (!isClosed) emit(state);
  }

  void addSampleItems(List<NonCooperationItemEntity> items) {
    items.addAll([
      NonCooperationItemEntity(
        id: 584713,
        emdadgarInfoId: 52056,
        agencyCode: "205029",
        agencyName: "محمد دهقان باني",
        cityId: 1605,
        cityName: "شهریار",
        provinceId: 16,
        provinceName: "تهران",
        customerCityId: 1601,
        customerCityName: "تهران",
        customerProvinceId: 16,
        customerProvinceName: "تهران",
        aidPerCode: 5306777,
        aidPerName: "محمد دهقان بانی",
        serviceRequestTrackCode: 87793,
        typeOfLack: 648,
        typeOfLackTitle: "عدم همکاری نوع اول برای درخواست های بسته شده در ورکر",
        authorId: 4955,
        authorFullname: "مدیر سیستم",
        submitDateTime: "2026-02-28T09:00:21",
        callDateTime: "2026-02-17T14:49:50",
        customerType: 1,
        customerTypeName: "Subscriber",
        customerTypeTitle: "مشترک",
        description: "ندارد",
        submitDateJalali: "1404/12/09",
        submitTime: "09:00:21",
        callDateJalali: "1404/11/28",
        callTime: "14:49:50",
        serviceRequestId: 30180,
        serviceType: 2,
      ),
      NonCooperationItemEntity(
        id: 584711,
        emdadgarInfoId: 52056,
        agencyCode: "205029",
        agencyName: "محمد دهقان باني",
        cityId: 1605,
        cityName: "شهریار",
        provinceId: 16,
        provinceName: "تهران",
        customerCityId: 1601,
        customerCityName: "تهران",
        customerProvinceId: 16,
        customerProvinceName: "تهران",
        aidPerCode: 5306777,
        aidPerName: "محمد دهقان بانی",
        serviceRequestTrackCode: 87793,
        typeOfLack: 560,
        typeOfLackTitle: "خرابی خودرو",
        authorId: 4955,
        authorFullname: "مدیر سیستم",
        submitDateTime: "2026-02-28T08:44:17",
        callDateTime: "2026-02-17T14:49:50",
        customerType: 1,
        customerTypeName: "Subscriber",
        customerTypeTitle: "مشترک",
        description: "خودرو خدمت رسان خراب شده است",
        submitDateJalali: "1404/12/09",
        submitTime: "08:44:17",
        callDateJalali: "1404/11/28",
        callTime: "14:49:50",
        serviceRequestId: 30180,
        serviceType: 2,
      ),
    ]);
  }

}
