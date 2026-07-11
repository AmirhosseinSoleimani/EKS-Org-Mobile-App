import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'cartable_tree_callbacks.dart';
import 'cartable_tree_node_tile.dart';
import 'cartable_tree_utils.dart';

class CartableTreeNode extends StatelessWidget {
  final SubordinatedUserEntity item;
  final List<SubordinatedUserEntity> path;

  final Set<String> expandedNodeKeys;
  final String? selectedNodeKey;
  final bool forceExpanded;

  final TreeNodeToggleCallback onToggle;
  final TreeNodeSelectionCallback onSelect;

  const CartableTreeNode({
    super.key,
    required this.item,
    required this.path,
    required this.expandedNodeKeys,
    required this.selectedNodeKey,
    required this.forceExpanded,
    required this.onToggle,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final nodeKey = createCartableTreePathKey(path);
    final hasChildren = item.subordinateds.isNotEmpty;

    final isExpanded =
        hasChildren && (forceExpanded || expandedNodeKeys.contains(nodeKey));

    final isSelected = selectedNodeKey == nodeKey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CartableTreeNodeTile(
          item: item,
          nodeKey: nodeKey,
          path: path,
          hasChildren: hasChildren,
          isExpanded: isExpanded,
          isSelected: isSelected,
          onToggle: onToggle,
          onSelect: onSelect,
        ),
        if (isExpanded)
          _ChildrenSection(
            parentPath: path,
            children: item.subordinateds,
            expandedNodeKeys: expandedNodeKeys,
            selectedNodeKey: selectedNodeKey,
            forceExpanded: forceExpanded,
            onToggle: onToggle,
            onSelect: onSelect,
          ),
      ],
    );
  }
}

class _ChildrenSection extends StatelessWidget {
  final List<SubordinatedUserEntity> parentPath;
  final List<SubordinatedUserEntity> children;

  final Set<String> expandedNodeKeys;
  final String? selectedNodeKey;
  final bool forceExpanded;

  final TreeNodeToggleCallback onToggle;
  final TreeNodeSelectionCallback onSelect;

  const _ChildrenSection({
    required this.parentPath,
    required this.children,
    required this.expandedNodeKeys,
    required this.selectedNodeKey,
    required this.forceExpanded,
    required this.onToggle,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: AppPadding.p16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            start: -12,
            top: 0,
            bottom: AppSize.s8,
            child: Container(
              width: 1,
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final child in children)
                CartableTreeNode(
                  key: ValueKey(
                    createCartableTreePathKey([...parentPath, child]),
                  ),
                  item: child,
                  path: [...parentPath, child],
                  expandedNodeKeys: expandedNodeKeys,
                  selectedNodeKey: selectedNodeKey,
                  forceExpanded: forceExpanded,
                  onToggle: onToggle,
                  onSelect: onSelect,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
