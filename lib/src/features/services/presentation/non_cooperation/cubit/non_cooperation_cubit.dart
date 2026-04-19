import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_non_cooperation_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'non_cooperation_cubit.freezed.dart';

part 'non_cooperation_state.dart';

class NonCooperationCubit extends Cubit<NonCooperationState> {
  final GetNonCooperationListUseCase _getNonCooperationListUseCase;

  NonCooperationCubit(this._getNonCooperationListUseCase)
      : super(const NonCooperationState.idle());

  NonCooperationListEntity? _listEntity;
  BaseRequestEntity? selectedRequest;

  final List<NonCooperationItemEntity> items = [];

  int _page = 1;
  bool _hasMore = true;

  Future<void> init() async {
    emit(const NonCooperationState.loading());

    final result = await _getNonCooperationListUseCase();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        _listEntity = data;
        if (data != null) {
          items.addAll(data.records);
        }
        //_hasMore = items.length < data.totalCount;

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

  void _safeEmit(NonCooperationState state) {
    if (!isClosed) emit(state);
  }
}
