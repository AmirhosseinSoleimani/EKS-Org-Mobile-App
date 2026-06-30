import 'package:eks_sana_plus_org/src/features/cartable/data/data_sources/cartable_data_source.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/service/cartable_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartableDataSource)
class CartableDataSourceImpl extends CartableDataSource {
  final CartableService _service;

  CartableDataSourceImpl(this._service);
}
