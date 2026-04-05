import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository_share_data.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: RequestRepositoryShareData)
class RequestRepositoryShareDataImpl implements RequestRepositoryShareData {
  static final RequestRepositoryShareDataImpl _instance =
      RequestRepositoryShareDataImpl._internal();

  factory RequestRepositoryShareDataImpl() => _instance;

  RequestRepositoryShareDataImpl._internal();

  final BehaviorSubject<RequestEntity> _requestProductSubject =
      BehaviorSubject.seeded(const RequestEntity());

  @override
  RequestEntity get fetchSelectedRequestItem =>
       _requestProductSubject.value;

  @override
  void setSelectedRequestItem(RequestEntity request) =>
      _requestProductSubject.add(request);

  @override
  void dispose() {
    _requestProductSubject.close();
  }
}
