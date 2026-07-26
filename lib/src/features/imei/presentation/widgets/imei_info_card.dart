import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class ImeiInfoCard extends StatelessWidget {
  const ImeiInfoCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final ImeiInfoEntity item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              StatusLabel(
                text: item.isActive == true ? 'فعال' : 'غیرفعال',
                backgroundColor: item.isActive == true
                    ? theme.colorScheme.primary.withOpacity(0.14)
                    : theme.colorScheme.error.withOpacity(0.12),
                color: item.isActive == true
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
              const Spacer(),
              TitleLargeText(
                text: item.deviceName ?? '---',
                color: theme.colorScheme.onSurface,
                fontSize: AppSize.s18,
              ),
              Space.w12,
              CircleAvatar(
                radius: AppSize.s24,
                backgroundColor: theme.colorScheme.secondaryContainer,
                child: Icon(
                  Icons.router_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          Space.h16,
          _InfoRow(
            icon: Icons.sim_card_outlined,
            title: 'شماره سیمکارت',
            value: item.simNumber,
          ),
          Space.h12,
          _InfoRow(
            icon: Icons.qr_code_2_outlined,
            title: 'سریال دستگاه',
            value: item.avlSerial,
          ),
          Space.h12,
          _InfoRow(
            icon: Icons.memory_outlined,
            title: 'IMEI',
            value: item.imei,
          ),
          Space.h14,
          Divider(color: theme.colorScheme.outlineVariant),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت کننده: ${item.insertUserFullName ?? '---'}',
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              BodySmallText(
                text: item.insertDateTimeJalali ?? '---',
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          Space.h14,
          _ActionButton(
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.onSurfaceVariant, size: AppSize.s20),
        Space.w8,
        BodyMediumText(
          text: '$title: ',
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        Expanded(
          child: BodyMediumText(
            text: value?.trim().isNotEmpty == true ? value! : '---',
            color: colorScheme.onSurfaceVariant,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  final _key = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _openOverlay() {
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || _overlayEntry != null) return;

    final position = box.localToGlobal(Offset(0, box.size.height + 4));
    _overlayEntry = OverlayEntry(
      builder: (_) => OverlayDropdownMenu<_ImeiActionItem>(
        position: position,
        width: box.size.width,
        items: _ImeiActionItem.values,
        onDismiss: _removeOverlay,
        onSelect: (item) {
          _removeOverlay();
          switch (item.value) {
            case _ImeiAction.edit:
              widget.onEdit();
              break;
            case _ImeiAction.delete:
              widget.onDelete();
              break;
          }
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      key: _key,
      onTap: _openOverlay,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        height: AppSize.s40,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings_outlined, color: theme.colorScheme.onSurface),
            Space.w8,
            BodyMediumText(
              text: 'عملیات',
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            Space.w8,
            Icon(Icons.keyboard_arrow_down, color: theme.colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}

enum _ImeiAction { edit, delete }

class _ImeiActionItem implements DropdownItem<_ImeiAction> {
  const _ImeiActionItem(this.value, this.label);

  static const values = [
    _ImeiActionItem(_ImeiAction.edit, 'ویرایش'),
    _ImeiActionItem(_ImeiAction.delete, 'حذف'),
  ];

  @override
  final _ImeiAction value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) {
    return Icon(
      value == _ImeiAction.edit ? Icons.edit_outlined : Icons.delete_outline,
      size: AppSize.s20,
      color: value == _ImeiAction.delete
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.onSurface,
    );
  }
}
