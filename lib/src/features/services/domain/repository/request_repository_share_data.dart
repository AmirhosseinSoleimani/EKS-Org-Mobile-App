import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';

abstract class RequestRepositoryShareData {
  BaseRequestEntity? get fetchSelectedRequestItem;

  void setSelectedRequestItem(BaseRequestEntity subscriptionProduct);

  void dispose();
}
