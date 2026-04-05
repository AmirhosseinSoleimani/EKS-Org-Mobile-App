import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';

abstract class RequestRepositoryShareData {
  RequestEntity get fetchSelectedRequestItem;

  void setSelectedRequestItem(RequestEntity subscriptionProduct);

  void dispose();
}
