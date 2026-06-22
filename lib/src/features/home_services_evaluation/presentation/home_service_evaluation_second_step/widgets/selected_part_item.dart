import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class SelectedPartListItem extends StatelessWidget {
  final EvaluationPartResponseEntity part;

  final bool hasBorder;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SelectedPartListItem({
    super.key,
    required this.part,
    required this.onEdit,
    required this.onDelete,
    this.hasBorder = true,
  });

  static const _radius = 6.0;
  static const _bgColor = Color(0x66F2F2F2);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.only(left: 8.0, right: 16.0, top: 16, bottom: 16 ),
      decoration: BoxDecoration(
        color: _bgColor,
        border: hasBorder ? Border.all(color: color.onInverseSurface) : null,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: _PartContent(part: part, onEdit: onEdit, onDelete: onDelete),
    );
  }
}

class _PartContent extends StatelessWidget {
  final EvaluationPartResponseEntity part;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PartContent({
    required this.part,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeaderRow(
          part: part,
          onMenuTap: () => _openBottomSheet(context, onEdit, onDelete),
        ),
        Space.h8,
        _InfoRow(part: part),
        Space.h8,
        _CostCenter(part: part),
      ],
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final EvaluationPartResponseEntity part;
  final VoidCallback onMenuTap;

  const _HeaderRow({required this.part, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BodyMediumText(
            text: part.partName ?? '',
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
            color: color.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: onMenuTap,
          child: Icon(Icons.more_vert, color: color.onSurface),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final EvaluationPartResponseEntity part;

  const _InfoRow({required this.part});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'تعداد: ${part.count ?? '-'}',
            style: TextStyle(
              color: color.onSurfaceVariant,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            part.partPrice?.toRialPrice() ?? '',
            style: TextStyle(color: color.onSurface, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _CostCenter extends StatelessWidget {
  final EvaluationPartResponseEntity part;

  const _CostCenter({required this.part});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Text(
      'مرکز هزینه: ${part.costCenterObject?.name ?? '-'}',
      style: TextStyle(
        color: color.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

void _openBottomSheet(
  BuildContext context,
  VoidCallback onEdit,
  VoidCallback onDelete,
) {
  final color = Theme.of(context).colorScheme;

  BottomSheetMessage.showCustom(
    context: context,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionItem(
          icon: SvgManager.edit,
          title: 'ویرایش',
          onTap: () {
            Navigator.pop(context);
            onEdit();
          },
        ),
        Divider(color: Colors.grey.withAlpha(100)),
        _ActionItem(
          icon: SvgManager.delete,
          title: 'حذف',
          iconColor: color.error,
          textColor: color.error,
          onTap: () {
            Navigator.pop(context);
            onDelete();
          },
        ),
      ],
    ),
  );
}

class _ActionItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _ActionItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: color.primary.withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              SvgWidget(src: SvgSrc.asset(icon), color: iconColor),
              const SizedBox(width: 12),
              BodyMediumText(
                text: title,
                color: textColor ?? color.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension RialPriceFormatter on num {
  String toRialPrice() {
    final value = toStringAsFixed(
      0,
    ).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');

    return '$value ریال';
  }
}
