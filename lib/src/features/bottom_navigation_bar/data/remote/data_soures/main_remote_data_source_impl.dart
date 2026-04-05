
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../models/urgent_request_model.dart';
import '../service/main_service.dart';
import 'main_remote_data_source.dart';

@LazySingleton(as: MainRemoteDataSource)
class MainRemoteDataSourceImpl extends MainRemoteDataSource {
  final MainService _service;

  MainRemoteDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<UrgentRequestModel>> sendUrgentRequest() async {
    final result = await _service.sendUrgentRequest({});
    return result;
  }
}
