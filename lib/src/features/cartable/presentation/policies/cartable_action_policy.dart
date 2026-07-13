import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';

import '../actions/cartable_action_codes.dart';

abstract final class CartableActionPolicy {
  static const Set<CartableActionType> _directActionTypes = {
    CartableActionType.viewRequest,
    CartableActionType.delegateCartable,
  };

  static CartableItemActionEntity? findByCode({
    required List<CartableItemActionEntity> actions,
    required String code,
  }) {
    final normalizedCode = _normalize(code);

    for (final action in actions) {
      if (_normalize(action.code) == normalizedCode) {
        return action;
      }
    }

    return null;
  }

  static bool isDirectAction(String? code) {
    final actionType = CartableActionCodes.resolveType(code);

    return _directActionTypes.contains(actionType);
  }

  static bool isMenuAction(
      CartableItemActionEntity action,
      ) {
    return _hasValidTitle(action) &&
        !isDirectAction(action.code);
  }

  static List<CartableItemActionEntity> resolveMenuActions(
      List<CartableItemActionEntity> actions,
      ) {
    final result = actions
        .where(isMenuAction)
        .toList();

    result.sort(_compareByOrder);

    return result;
  }

  static bool _hasValidTitle(
      CartableItemActionEntity action,
      ) {
    return action.title?.trim().isNotEmpty == true;
  }

  static int _compareByOrder(
      CartableItemActionEntity first,
      CartableItemActionEntity second,
      ) {
    return (first.orderNo ?? 0).compareTo(
      second.orderNo ?? 0,
    );
  }

  static String _normalize(String? value) {
    return value?.trim().toLowerCase() ?? '';
  }
}