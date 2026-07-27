import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/delete_rescuer_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuer_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart'
    show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'rescuer_detail_cubit.freezed.dart';
part 'rescuer_detail_state.dart';

@injectable
class RescuerDetailCubit extends Cubit<RescuerDetailState> {
  RescuerDetailCubit(this._getRescuerByIdUseCase, this._deleteRescuerUseCase)
    : super(const RescuerDetailState.idle());

  final GetRescuerByIdUseCase _getRescuerByIdUseCase;
  final DeleteRescuerUseCase _deleteRescuerUseCase;

  VoidCallback? _retryAction;

  RescuerEntity? get rescuer => state.data.rescuer;

  List<SkillCertificateEntity> get skillCertificates =>
      state.data.skillCertificates;

  List<SanHistoryEntity> get histories => state.data.histories;

  bool get isDeleting => state.data.isDeleting;

  bool get hasRetryAction => _retryAction != null;

  void retryLastAction() => _retryAction?.call();

  Future<void> loadDetails(int id) async {
    _retryAction = () {
      loadDetails(id);
    };

    emit(RescuerDetailState.loading(data: state.data));

    final detailResult = await _getRescuerByIdUseCase(id);
    RescuerEntity? loadedRescuer;
    BottomSheetMessageModel? failure;
    var hasConnectionError = false;

    detailResult.whenOrNull(
      success: (data, failures, resultCode) {
        loadedRescuer = data;
      },
      failure: (error, message) {
        failure = _buildErrorMessage(
          title: 'خطا در دریافت جزئیات',
          message:
              message ??
              error?.toString() ??
              'دریافت اطلاعات امدادرسان با خطا مواجه شد.',
        );
      },
      connectionError: () {
        hasConnectionError = true;
      },
    );

    if (hasConnectionError) {
      _safeEmit(RescuerDetailState.connectionError(data: state.data));
      return;
    }
    if (failure != null || loadedRescuer == null) {
      _safeEmit(
        RescuerDetailState.error(
          data: state.data,
          message:
              failure ??
              _buildErrorMessage(
                title: 'خطا در دریافت جزئیات',
                message: 'اطلاعات امدادرسان دریافت نشد.',
              ),
        ),
      );
      return;
    }

    _safeEmit(
      RescuerDetailState.loaded(
        data: state.data.copyWith(rescuer: loadedRescuer),
      ),
    );
  }

  Future<bool> deleteRescuer() async {
    final id = state.data.rescuer?.id;
    if (id == null || state.data.isDeleting) return false;

    _retryAction = () {
      deleteRescuer();
    };

    emit(
      RescuerDetailState.actionLoading(
        data: state.data.copyWith(isDeleting: true),
      ),
    );

    var isSuccessful = false;
    final result = await _deleteRescuerUseCase(id);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        isSuccessful = true;
        _safeEmit(
          RescuerDetailState.loaded(
            data: state.data.copyWith(isDeleting: false),
          ),
        );
      },
      failure: (error, message) {
        _safeEmit(
          RescuerDetailState.actionError(
            data: state.data.copyWith(isDeleting: false),
            message:
                message ??
                error?.toString() ??
                'حذف امدادرسان با خطا مواجه شد.',
          ),
        );
      },
      connectionError: () {
        _safeEmit(
          RescuerDetailState.actionError(
            data: state.data.copyWith(isDeleting: false),
            message: 'اتصال اینترنت خود را بررسی کنید.',
          ),
        );
      },
    );

    return isSuccessful;
  }

  BottomSheetMessageModel _buildErrorMessage({
    required String title,
    required String message,
  }) {
    return BottomSheetMessageModel(title: title, message: message);
  }

  void _safeEmit(RescuerDetailState nextState) {
    if (!isClosed) emit(nextState);
  }
}
