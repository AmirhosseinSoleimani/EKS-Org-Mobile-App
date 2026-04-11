import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository_share_data.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: RequestRepositoryShareData)
class RequestRepositoryShareDataImpl implements RequestRepositoryShareData {
  static final RequestRepositoryShareDataImpl _instance =
      RequestRepositoryShareDataImpl._internal();

  factory RequestRepositoryShareDataImpl() => _instance;

  RequestRepositoryShareDataImpl._internal();

  final BehaviorSubject<BaseRequestEntity?> _requestProductSubject =
      BehaviorSubject.seeded(null);

  @override
  BaseRequestEntity? get fetchSelectedRequestItem =>
      _requestProductSubject.value;

  @override
  void setSelectedRequestItem(BaseRequestEntity request) =>
      _requestProductSubject.add(request);

  @override
  void dispose() {
    _requestProductSubject.close();
  }
}
