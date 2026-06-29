import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';

class CartableItemActionModel extends CartableItemActionEntity {
  const CartableItemActionModel({
    super.guid,
    super.title,
    super.code,
    super.buttonCssClass,
    super.iconCssClass,
    super.orderNo,
  });

  factory CartableItemActionModel.fromJson(Map<String, dynamic> json) {
    return CartableItemActionModel(
      guid: json['guid'] as String?,
      title: json['title'] as String?,
      code: json['code'] as String?,
      buttonCssClass: json['buttonCssClass'] as String?,
      iconCssClass: json['iconCssClass'] as String?,
      orderNo: json['orderNo'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'title': title,
      'code': code,
      'buttonCssClass': buttonCssClass,
      'iconCssClass': iconCssClass,
      'orderNo': orderNo,
    };
  }
}
