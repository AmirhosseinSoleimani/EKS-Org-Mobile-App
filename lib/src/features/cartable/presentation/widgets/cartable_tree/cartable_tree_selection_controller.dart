import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:flutter/foundation.dart';

class CartableTreeSelection {
  final String nodeKey;
  final SubordinatedUserEntity item;
  final List<SubordinatedUserEntity> path;

  const CartableTreeSelection({
    required this.nodeKey,
    required this.item,
    required this.path,
  });
}

class CartableTreeSelectionController {
  final ValueNotifier<String?> selectedNodeKey = ValueNotifier<String?>(null);
  final ValueNotifier<CartableTreeSelection?> selectedSelection =
      ValueNotifier<CartableTreeSelection?>(null);

  final Map<String, ValueNotifier<bool>> _selectionStates = {};

  ValueListenable<bool> selectionListenableFor(String nodeKey) {
    return _selectionStates.putIfAbsent(
      nodeKey,
      () => ValueNotifier<bool>(selectedNodeKey.value == nodeKey),
    );
  }

  void select({
    required String nodeKey,
    required SubordinatedUserEntity item,
    required List<SubordinatedUserEntity> path,
  }) {
    final previousKey = selectedNodeKey.value;

    if (previousKey == nodeKey) {
      return;
    }

    if (previousKey != null) {
      _selectionStates[previousKey]?.value = false;
    }

    final currentState = _selectionStates.putIfAbsent(
      nodeKey,
      () => ValueNotifier<bool>(false),
    );

    currentState.value = true;
    selectedNodeKey.value = nodeKey;
    selectedSelection.value = CartableTreeSelection(
      nodeKey: nodeKey,
      item: item,
      path: List<SubordinatedUserEntity>.unmodifiable(path),
    );
  }

  void clear() {
    final previousKey = selectedNodeKey.value;

    if (previousKey != null) {
      _selectionStates[previousKey]?.value = false;
    }

    selectedNodeKey.value = null;
    selectedSelection.value = null;
  }

  void dispose() {
    selectedNodeKey.dispose();
    selectedSelection.dispose();

    for (final notifier in _selectionStates.values) {
      notifier.dispose();
    }

    _selectionStates.clear();
  }
}
