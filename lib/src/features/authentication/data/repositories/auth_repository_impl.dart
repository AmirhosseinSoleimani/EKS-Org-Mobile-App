import 'package:eks_sana_plus_org/src/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/send_otp_code_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/data_source/session_storage.dart';
import 'package:eks_sana_plus_org/src/services/local_service/session_local_storage_service/data/model/session_model.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _dataSource;
  final SessionStorage _sessionStorage;

  AuthRepositoryImpl(
      this._dataSource,
      this._sessionStorage,
      );

  @override
  Future<ApiResult> sendOTPCode(SendOtpCodeRequestEntity? entity) async {
    try {
      final updatedEntity = entity?.copyWith(
        channelType: kIsWeb ? 'PWA' : 'MobileApp'
      );
      final result = await _dataSource.sendOtpCode(updatedEntity?.toModel());
      if (result.resultCode == 0 && result.data != null) {
        await _sessionStorage.saveSessionId(
          SessionModel(
            sessionId: result.data?.token
          )
        );
      }
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<UserEntity?>> login(LoginRequestEntity? entity) async {
    try {
      final sessionModel = await _sessionStorage.fetchSessionId();
      final updatedEntity = entity?.copyWith(
          fcmToken: sessionModel?.sessionId
      );
      final result = await _dataSource.login(updatedEntity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
