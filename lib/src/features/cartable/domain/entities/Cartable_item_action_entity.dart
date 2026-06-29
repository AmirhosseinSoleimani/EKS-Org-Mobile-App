import 'package:eks_sana_plus_org/src/features/cartable/data/models/Cartable_item_action_model.dart';

class CartableItemActionEntity {
  final String? guid;
  final String? title;
  final String? code;
  final String? buttonCssClass;
  final String? iconCssClass;
  final int? orderNo;

  const CartableItemActionEntity({
    this.guid,
    this.title,
    this.code,
    this.buttonCssClass,
    this.iconCssClass,
    this.orderNo,
  });

  CartableItemActionModel toModel() {
    return CartableItemActionModel(
      guid: guid,
      title: title,
      code: code,
      buttonCssClass: buttonCssClass,
      iconCssClass: iconCssClass,
      orderNo: orderNo,
    );
  }

  CartableItemActionEntity copyWith({
    String? guid,
    String? title,
    String? code,
    String? buttonCssClass,
    String? iconCssClass,
    int? orderNo,
  }) {
    return CartableItemActionEntity(
      guid: guid ?? this.guid,
      title: title ?? this.title,
      code: code ?? this.code,
      buttonCssClass: buttonCssClass ?? this.buttonCssClass,
      iconCssClass: iconCssClass ?? this.iconCssClass,
      orderNo: orderNo ?? this.orderNo,
    );
  }
}
