import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class CartableTreeNodeAvatar extends StatelessWidget {
  final SubordinatedUserEntity item;
  final bool isOnline;

  const CartableTreeNodeAvatar({
    super.key,
    required this.item,
    required this.isOnline,
  });

  IconData get _icon {
    if (item.isRoot == true) {
      return Icons.groups_outlined;
    }

    if (item.isUser == true) {
      return Icons.person_outline;
    }

    return Icons.group_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: AppSize.s20,
          backgroundColor: colorScheme.primary.withValues(
            alpha: 0.12,
          ),
          child: Icon(
            _icon,
            size: AppSize.s20,
            color: colorScheme.primary,
          ),
        ),
        if (isOnline)
          PositionedDirectional(
            start: -1.5,
            bottom: -1.5,
            child: Container(
              width: AppSize.s14,
              height: AppSize.s14,
              decoration: BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFDCFCE7),
                  width: 2.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}