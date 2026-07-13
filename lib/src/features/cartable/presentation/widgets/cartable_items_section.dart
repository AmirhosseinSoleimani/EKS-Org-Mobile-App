import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/cartable_item_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';

class CartableItemsSection extends StatelessWidget {
  final bool hasSelectedUser;
  final bool isLoading;
  final List<CartableItemEntity> items;
  final CartableItemActionTap onActionTap;

  const CartableItemsSection({
    super.key,
    required this.hasSelectedUser,
    required this.isLoading,
    required this.items,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasSelectedUser) {
      return const SizedBox.shrink();
    }

    if (isLoading) {
      return const _CartableItemsLoading();
    }

    if (items.isEmpty) {
      return const EmptyListWidget();
    }

    return ListView.separated(
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.only(
        bottom: AppPadding.p16,
      ),
      itemCount: items.length,
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: AppSize.s12,
        );
      },
      itemBuilder: (context, index) {
        return CartableItemCard(
          item: items[index],
          onActionTap: onActionTap,
        );
      },
    );
  }
}

class _CartableItemsLoading extends StatelessWidget {
  const _CartableItemsLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}