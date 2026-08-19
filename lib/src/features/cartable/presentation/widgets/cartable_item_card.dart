import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/actions/cartable_action_codes.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/policies/cartable_action_policy.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/cartable_actions_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/direct_action_button.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

typedef CartableItemActionTap =
    void Function(CartableItemEntity item, CartableItemActionEntity action);

class CartableItemCard extends StatelessWidget {
  final CartableItemEntity item;
  final CartableItemActionTap onActionTap;
  final bool isDelegateLoading;

  const CartableItemCard({
    super.key,
    required this.item,
    required this.onActionTap,
    this.isDelegateLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeaderSection(item: item),

                const SizedBox(height: AppSize.s24),

                Divider(
                  height: 1,
                  thickness: 1,
                  color: colorScheme.onSurfaceVariant.withAlpha(45),
                ),

                const SizedBox(height: AppSize.s24),

                _SenderReceiverSection(item: item),
              ],
            ),
          ),

          const SizedBox(height: AppSize.s24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: _RequestInformationBox(item: item),
          ),

          const SizedBox(height: AppSize.s24),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppPadding.p16,
              0,
              AppPadding.p16,
              AppPadding.p16,
            ),
            child: _ActionSection(
              item: item,
              onActionTap: onActionTap,
              isDelegateLoading: isDelegateLoading,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final CartableItemEntity item;

  const _HeaderSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListItemTitleText(
                text: _resolveSubject(item),
                maxLines: 2,
              ),
            ),

            const SizedBox(width: AppSize.s16),

            ListItemMetaText(
              text: _resolveDateAndTime(item),
              textDirection: TextDirection.ltr,
            ),
          ],
        ),

        const SizedBox(height: AppSize.s6),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListItemLabelValueText(
                label: 'شماره درخواست',
                value: item.serviceRequestTrackCode?.toString(),
              ),
            ),

            const SizedBox(width: AppSize.s12),

            Flexible(
              child: ListItemValueText(
                text: _resolveStatus(item),
                maxLines: 1,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SenderReceiverSection extends StatelessWidget {
  final CartableItemEntity item;

  const _SenderReceiverSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _PersonInformation(
          title: 'ارسال‌کننده:',
          name: _resolveSenderName(item),
        ),
        Space.w24,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SvgWidget(src: SvgAsset(SvgManager.arrowLeftAlt)),
        ),
        Space.w24,
        Expanded(
          child: _PersonInformation(
            title: 'دریافت‌کننده:',
            name: _resolveReceiverName(item),
          ),
        ),
      ],
    );
  }
}

class _PersonInformation extends StatelessWidget {
  final String title;
  final String name;

  const _PersonInformation({required this.title, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListItemLabelText(
          text: title,
          maxLines: 1,
        ),

        const SizedBox(height: AppSize.s8),

        ListItemValueText(
          text: name,
          maxLines: 2,
        ),
      ],
    );
  }
}

class _RequestInformationBox extends StatelessWidget {
  final CartableItemEntity item;

  const _RequestInformationBox({required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: colorScheme.surface.withAlpha(25),
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: colorScheme.onInverseSurface),
      ),
      child: Column(
        children: [
          _InformationRow(
            title: 'شماره تماس مشتری:',
            value: _resolveCustomerPhone(item),
          ),

          const SizedBox(height: AppSize.s12),

          _InformationRow(
            title: 'نام امدادگر:',
            value: _resolveAidWorkerName(item),
          ),

          const SizedBox(height: AppSize.s12),

          _InformationRow(
            title: 'ایراد خودرو:',
            value: _resolveVehicleIssue(item),
          ),
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  final String title;
  final String value;

  const _InformationRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListItemLabelValueText(
      label: title.replaceFirst(RegExp(r':$'), ''),
      value: value,
      maxLines: 2,
    );
  }
}

class _ActionSection extends StatelessWidget {
  final CartableItemEntity item;
  final CartableItemActionTap onActionTap;
  final bool isDelegateLoading;

  const _ActionSection({
    required this.item,
    required this.onActionTap,
    required this.isDelegateLoading,
  });

  @override
  Widget build(BuildContext context) {
    final actions = item.availableActions ?? const <CartableItemActionEntity>[];

    final detailsAction = CartableActionPolicy.findByCode(
      actions: actions,
      code: CartableActionCodes.viewRequest,
    );

    final transferAction = CartableActionPolicy.findByCode(
      actions: actions,
      code: CartableActionCodes.delegateCartable,
    );

    final menuActions = CartableActionPolicy.resolveMenuActions(actions);

    return Row(
      children: [
        Expanded(
          child: DirectActionButton(
            text: 'مشاهده جزئیات',
            action: detailsAction,
            isFilled: true,
            showIcon: false,
            onPressed: detailsAction == null
                ? null
                : () {
                    onActionTap(item, detailsAction);
                  },
          ),
        ),

        const SizedBox(width: AppSize.s8),

        Expanded(
          child: DirectActionButton(
            text: 'انتقال به کارتابل',
            action: transferAction,
            defaultIcon: null,
            isFilled: false,
            showIcon: true,
            isLoading: isDelegateLoading,
            onPressed: transferAction == null
                ? null
                : () {
                    onActionTap(item, transferAction);
                  },
          ),
        ),

        const SizedBox(width: AppSize.s12),

        _MoreActionsButton(
          enabled: menuActions.isNotEmpty,
          onTap: menuActions.isEmpty
              ? null
              : () {
                  _showMoreActions(context, menuActions);
                },
        ),
      ],
    );
  }

  void _showMoreActions(
    BuildContext context,
    List<CartableItemActionEntity> actions,
  ) {
    BottomSheetMessage.showCustom(
      context: context,
      maxHeight: 0.65,
      content: CartableActionsBottomSheet(
        actions: actions,
        onActionSelected: (action) {
          onActionTap(item, action);
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}

class _MoreActionsButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onTap;

  const _MoreActionsButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final iconColor = enabled
        ? colorScheme.onSurfaceVariant
        : colorScheme.onSurface.withAlpha(45);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppSize.s8),
        splashColor: colorScheme.primary.withAlpha(20),
        child: SizedBox(
          width: AppSize.s40,
          height: AppSize.s40,
          child: Icon(Icons.more_vert_rounded, color: iconColor),
        ),
      ),
    );
  }
}

String _resolveSubject(CartableItemEntity item) {
  final subject = item.subject?.trim();

  if (subject == null || subject.isEmpty) {
    return 'بدون عنوان';
  }

  return subject;
}

String _resolveDateAndTime(CartableItemEntity item) {
  final date = item.sendDateJalali?.trim();
  final time = _resolveShortTime(item.sendTime);

  final safeDate = date == null || date.isEmpty ? '-' : date;

  return '$safeDate - $time';
}

String _resolveShortTime(String? value) {
  final time = value?.trim();

  if (time == null || time.isEmpty) {
    return '-';
  }

  if (time.length >= 5) {
    return time.substring(0, 5);
  }

  return time;
}

String _resolveStatus(CartableItemEntity item) {
  final status = item.statusTitle?.trim();

  if (status == null || status.isEmpty) {
    return '-';
  }

  return status;
}

String _resolveSenderName(CartableItemEntity item) {
  final name = item.senderFullName?.trim();

  if (name == null || name.isEmpty) {
    return '-';
  }

  return name;
}

String _resolveReceiverName(CartableItemEntity item) {
  final name = item.receiverFullName?.trim();

  if (name == null || name.isEmpty) {
    return '-';
  }

  return name;
}

String _resolveCustomerPhone(CartableItemEntity item) {
  final phone = item.relatedTelNo?.trim();

  if (phone == null || phone.isEmpty) {
    return '-';
  }

  return phone;
}

String _resolveAidWorkerName(CartableItemEntity item) {
  final subject = item.subject?.trim();

  if (subject == null || subject.isEmpty) {
    return '-';
  }

  const separator = 'امدادگر:';

  final separatorIndex = subject.indexOf(separator);

  if (separatorIndex == -1) {
    return '-';
  }

  final name = subject.substring(separatorIndex + separator.length).trim();

  if (name.isEmpty) {
    return '-';
  }

  return name;
}

String _resolveVehicleIssue(CartableItemEntity item) {
  return '-';
}
