

import 'package:eks_sana_plus_org/src/features/representation/data/data_sources/representation_data_source.dart';
import 'package:eks_sana_plus_org/src/features/representation/data/service/representation_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RepresentationDataSource)
class RepresentationDataSourceImpl extends RepresentationDataSource {
  final RepresentationService _service;

  RepresentationDataSourceImpl(this._service);

/*  @override
  Future<BaseSingleResponse<DashboardModel?>> getDashboardData(
    DashboardParamModel param,
  ) async => await _service.getDashboardData(param.toJson());*/
}
