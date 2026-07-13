import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cartable_messages_badge.dart';
import 'cartable_tree_callbacks.dart';
import 'cartable_tree_node_avatar.dart';

class CartableTreeNodeTile extends StatelessWidget {
  static const int _onlineStatusValue = 1;

  final SubordinatedUserEntity item;
  final String nodeKey;
  final List<SubordinatedUserEntity> path;
  final bool hasChildren;
  final bool isExpanded;
  final ValueListenable<bool> isSelectedListenable;
  final TreeNodeToggleCallback onToggle;
  final TreeNodeSelectionCallback onSelect;

  const CartableTreeNodeTile({
    super.key,
    required this.item,
    required this.nodeKey,
    required this.path,
    required this.hasChildren,
    required this.isExpanded,
    required this.isSelectedListenable,
    required this.onToggle,
    required this.onSelect,
  });

  bool get _isOnline => item.onlineStatus == _onlineStatusValue;

  bool get _isLeaf => !hasChildren;

  void _handleSelection() {
    onSelect(
      item: item,
      path: path,
      nodeKey: nodeKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSelectedListenable,
      builder: (context, isSelected, _) {
        return _CartableTreeNodeTileBody(
          item: item,
          nodeKey: nodeKey,
          hasChildren: hasChildren,
          isLeaf: _isLeaf,
          isOnline: _isOnline,
          isExpanded: isExpanded,
          isSelected: isSelected,
          onToggle: () => onToggle(nodeKey),
          onSelect: _handleSelection,
        );
      },
    );
  }
}

class _CartableTreeNodeTileBody extends StatelessWidget {
  final SubordinatedUserEntity item;
  final String nodeKey;
  final bool hasChildren;
  final bool isLeaf;
  final bool isOnline;
  final bool isExpanded;
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onSelect;

  const _CartableTreeNodeTileBody({
    required this.item,
    required this.nodeKey,
    required this.hasChildren,
    required this.isLeaf,
    required this.isOnline,
    required this.isExpanded,
    required this.isSelected,
    required this.onToggle,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = isSelected
        ? colorScheme.primary.withValues(alpha: 0.10)
        : colorScheme.onPrimary;

    final borderColor = isSelected
        ? colorScheme.primary
        : colorScheme.onInverseSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppSize.s12),
              border: Border.all(
                color: borderColor,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSelect,
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Row(
                    children: [
                      _ExpandButton(
                        hasChildren: hasChildren,
                        isExpanded: isExpanded,
                        isSelected: isSelected,
                        onTap: onToggle,
                      ),
                      const SizedBox(width: AppSize.s4),
                      CartableTreeNodeAvatar(
                        item: item,
                        isOnline: isOnline,
                      ),
                      const SizedBox(width: AppSize.s12),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                _resolveName(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            if (isLeaf) ...[
                              const SizedBox(width: AppSize.s8),
                              CartableMessagesBadge(
                                count: item.cartableMessagesCount ?? 0,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (isLeaf) ...[
                        const SizedBox(width: AppSize.s8),
                        Radio<String>(
                          value: nodeKey,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                            (states) {
                              if (states.contains(WidgetState.selected)) {
                                return colorScheme.primary;
                              }

                              return const Color(0xFF8E8E8E);
                            },
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isSelected)
            PositionedDirectional(
              start: -2,
              top: AppSize.s10,
              bottom: AppSize.s10,
              child: Container(
                width: AppSize.s4,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _resolveName() {
    final name = item.name?.trim();

    if (name == null || name.isEmpty) {
      return '-';
    }

    return name;
  }
}

class _ExpandButton extends StatelessWidget {
  final bool hasChildren;
  final bool isExpanded;
  final bool isSelected;
  final VoidCallback onTap;

  const _ExpandButton({
    required this.hasChildren,
    required this.isExpanded,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasChildren) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: AppSize.s32,
      height: AppSize.s32,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        splashRadius: AppSize.s18,
        onPressed: onTap,
        icon: Icon(
          isExpanded
              ? Icons.keyboard_arrow_up_rounded
              : Icons.keyboard_arrow_left_rounded,
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
