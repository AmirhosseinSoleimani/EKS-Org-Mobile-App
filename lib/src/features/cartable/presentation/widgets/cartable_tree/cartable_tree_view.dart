import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:flutter/material.dart';

import 'cartable_tree_callbacks.dart';
import 'cartable_tree_node.dart';
import 'cartable_tree_utils.dart';
import 'empty_cartable_tree_result.dart';

class CartableTreeView extends StatelessWidget {
  final List<SubordinatedUserEntity> users;

  final Set<String> expandedNodeKeys;
  final String? selectedNodeKey;
  final bool forceExpanded;

  final TreeNodeToggleCallback onToggle;
  final TreeNodeSelectionCallback onSelect;

  const CartableTreeView({
    super.key,
    required this.users,
    required this.expandedNodeKeys,
    required this.selectedNodeKey,
    required this.forceExpanded,
    required this.onToggle,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const EmptyCartableTreeResult();
    }

    return ListView.builder(
      key: const PageStorageKey(
        'cartable-tree-list',
      ),
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.zero,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final item = users[index];
        final path = [item];

        return CartableTreeNode(
          key: ValueKey(
            createCartableTreePathKey(path),
          ),
          item: item,
          path: path,
          expandedNodeKeys: expandedNodeKeys,
          selectedNodeKey: selectedNodeKey,
          forceExpanded: forceExpanded,
          onToggle: onToggle,
          onSelect: onSelect,
        );
      },
    );
  }
}