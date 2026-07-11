import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:flutter/material.dart';

import 'cartable_tree_callbacks.dart';
import 'cartable_tree_node.dart';
import 'cartable_tree_selection_controller.dart';
import 'cartable_tree_utils.dart';
import 'empty_cartable_tree_result.dart';

class CartableTreeView extends StatelessWidget {
  final List<SubordinatedUserEntity> users;
  final bool forceExpanded;
  final CartableTreeSelectionController selectionController;
  final TreeNodeSelectionCallback onSelect;
  final ScrollController scrollController;

  const CartableTreeView({
    super.key,
    required this.users,
    required this.forceExpanded,
    required this.selectionController,
    required this.scrollController,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const EmptyCartableTreeResult();
    }

    return ListView.builder(
      controller: scrollController,
      key: const PageStorageKey<String>('cartable-tree-list'),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.zero,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final item = users[index];
        final path = <SubordinatedUserEntity>[item];
        final nodeKey = createCartableTreePathKey(path);

        return CartableTreeNode(
          key: ValueKey<String>(nodeKey),
          item: item,
          path: path,
          nodeKey: nodeKey,
          forceExpanded: forceExpanded,
          initiallyExpanded: item.isRoot == true,
          selectionController: selectionController,

          onSelect: onSelect,
        );
      },
    );
  }
}
