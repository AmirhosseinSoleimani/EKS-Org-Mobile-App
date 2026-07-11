import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'cartable_tree_callbacks.dart';
import 'cartable_tree_node_tile.dart';
import 'cartable_tree_selection_controller.dart';
import 'cartable_tree_utils.dart';

class CartableTreeNode extends StatefulWidget {
  final SubordinatedUserEntity item;
  final List<SubordinatedUserEntity> path;
  final String nodeKey;
  final bool forceExpanded;
  final bool initiallyExpanded;
  final CartableTreeSelectionController selectionController;
  final TreeNodeSelectionCallback onSelect;

  const CartableTreeNode({
    super.key,
    required this.item,
    required this.path,
    required this.nodeKey,
    required this.forceExpanded,
    required this.initiallyExpanded,
    required this.selectionController,
    required this.onSelect,
  });

  @override
  State<CartableTreeNode> createState() => _CartableTreeNodeState();
}

class _CartableTreeNodeState extends State<CartableTreeNode> {
  late bool _isExpanded;

  bool get _hasChildren => widget.item.subordinateds.isNotEmpty;

  bool get _effectiveExpanded {
    return _hasChildren && (widget.forceExpanded || _isExpanded);
  }

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded && _hasChildren;
  }

  void _toggleExpanded() {
    if (!_hasChildren || widget.forceExpanded) {
      return;
    }

    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RepaintBoundary(
          child: CartableTreeNodeTile(
            item: widget.item,
            nodeKey: widget.nodeKey,
            path: widget.path,
            hasChildren: _hasChildren,
            isExpanded: _effectiveExpanded,
            isSelectedListenable: widget.selectionController
                .selectionListenableFor(widget.nodeKey),
            onToggle: (_) => _toggleExpanded(),
            onSelect: widget.onSelect,
          ),
        ),
        if (_effectiveExpanded)
          _ChildrenSection(
            parentPath: widget.path,
            parentNodeKey: widget.nodeKey,
            children: widget.item.subordinateds,
            forceExpanded: widget.forceExpanded,
            selectionController: widget.selectionController,
            onSelect: widget.onSelect,
          ),
      ],
    );
  }
}

class _ChildrenSection extends StatelessWidget {
  final List<SubordinatedUserEntity> parentPath;
  final String parentNodeKey;
  final List<SubordinatedUserEntity> children;
  final bool forceExpanded;
  final CartableTreeSelectionController selectionController;
  final TreeNodeSelectionCallback onSelect;

  const _ChildrenSection({
    required this.parentPath,
    required this.parentNodeKey,
    required this.children,
    required this.forceExpanded,
    required this.selectionController,
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
                _buildChild(child),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChild(SubordinatedUserEntity child) {
    final childPath = <SubordinatedUserEntity>[...parentPath, child];
    final childNodeKey = '$parentNodeKey>${createCartableTreeNodeSegment(child)}';

    return CartableTreeNode(
      key: ValueKey<String>(childNodeKey),
      item: child,
      path: childPath,
      nodeKey: childNodeKey,
      forceExpanded: forceExpanded,
      initiallyExpanded: false,
      selectionController: selectionController,
      onSelect: onSelect,
    );
  }
}
