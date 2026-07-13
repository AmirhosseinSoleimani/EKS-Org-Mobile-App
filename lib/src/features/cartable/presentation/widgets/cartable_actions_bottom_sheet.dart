import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/resolvers/cartable_action_visual_resolver.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class CartableActionsBottomSheet
    extends StatelessWidget {
  final List<CartableItemActionEntity> actions;

  final ValueChanged<CartableItemActionEntity>
  onActionSelected;

  const CartableActionsBottomSheet({
    super.key,
    required this.actions,
    required this.onActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.p8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Text(
            'سایر عملیات',
            style:
            theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppSize.s16),

          ListView.separated(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: actions.length,
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: AppSize.s8,
              );
            },
            itemBuilder: (context, index) {
              final action = actions[index];

              return _ActionItem(
                action: action,
                onTap: () {
                  Navigator.of(context).pop();

                  onActionSelected(action);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final CartableItemActionEntity action;
  final VoidCallback onTap;

  const _ActionItem({
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final visual =
    CartableActionVisualResolver.resolve(
      context: context,
      action: action,
    );

    return Material(
      color: visual.color.withAlpha(12),
      borderRadius: BorderRadius.circular(
        AppSize.s8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
        splashColor:
        visual.color.withAlpha(25),
        child: Padding(
          padding: const EdgeInsets.all(
            AppPadding.p12,
          ),
          child: Row(
            children: [
              Container(
                width: AppSize.s40,
                height: AppSize.s40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                  visual.color.withAlpha(22),
                  borderRadius:
                  BorderRadius.circular(
                    AppSize.s8,
                  ),
                ),
                child: Icon(
                  visual.icon,
                  size: AppSize.s20,
                  color: visual.color,
                ),
              ),

              const SizedBox(
                width: AppSize.s12,
              ),

              Expanded(
                child: Text(
                  action.title?.trim().isNotEmpty ==
                      true
                      ? action.title!.trim()
                      : '-',
                  style: theme
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Icon(
                Icons.chevron_left_rounded,
                color: theme.colorScheme
                    .onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}