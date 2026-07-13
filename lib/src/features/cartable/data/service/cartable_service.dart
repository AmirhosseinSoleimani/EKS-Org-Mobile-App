import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/cartable/data/models/cartable_item_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/models/delegate_cartable_message_response_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/data/models/subordinated_user_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cartable_service.g.dart';

@RestApi()
@lazySingleton
abstract class CartableService {
  @factoryMethod
  factory CartableService(Dio dio) = _CartableService;

  @POST('/api/UserInfo/GetSubordinatedUsers')
  Future<BaseListResponse<SubordinatedUserModel>> getSubordinatedUsers(@Body() Map<String, dynamic> body);

  @POST('/api/Cartable/GetByFilterJson')
  Future<BaseListResponse<CartableItemModel>> getCartableItemList(
      @Body() Map<String, dynamic> body);

  @POST('/api/Cartable/DelegateCartableMessage')
  Future<BaseSingleResponse<DelegateCartableMessageResponseModel>> delegateCartableMessage(
      @Body() Map<String, dynamic> body);
}
