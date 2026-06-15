import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class SelectedLaborListItem extends StatelessWidget {
  final EvaluationSelectedLaborEntity labor;
  final bool isPartsExpanded;
  final VoidCallback onAddPart;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleShowMoreParts;

  const SelectedLaborListItem({
    super.key,
    required this.labor,
    required this.isPartsExpanded,
    required this.onAddPart,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleShowMoreParts,
  });

  static const _borderRadius = 6.0;
  static const _itemPadding = 12.0;
  static const _animationDuration = Duration(milliseconds: 250);

  static const _backgroundColor = Color(0x66F2F2F2);
  static const _dividerColor = Color(0xFFE7E7E7);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_itemPadding),
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(color: colorScheme.onInverseSurface),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LaborHeaderRow(labor: labor),
          Space.h8,
          _LaborInfo(labor: labor),
          _PartsSection(
            parts: labor.evaluationParts,
            isExpanded: isPartsExpanded,
            animationDuration: _animationDuration,
            onToggleShowMore: onToggleShowMoreParts,
          ),
          Space.h12,
          _LaborActionButtons(
            onAddPart: onAddPart,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

class _LaborHeaderRow extends StatelessWidget {
  final EvaluationSelectedLaborEntity labor;

  const _LaborHeaderRow({required this.labor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: TitleLargeText(text: labor.name, fontSize: 14)),
        Space.w8,
        TitleLargeText(text: labor.price.toRialPrice(), fontSize: 14),
      ],
    );
  }
}

class _LaborInfo extends StatelessWidget {
  final EvaluationSelectedLaborEntity labor;

  const _LaborInfo({required this.labor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodySmallText(
          text: 'کد: ${labor.laborCode}',
          color: colorScheme.onPrimaryFixed,
        ),
        Space.h8,
        BodySmallText(
          text: 'مرکز هزینه: ${labor.costCenter.name ?? '-'}',
          color: colorScheme.onPrimaryFixed,
        ),
      ],
    );
  }
}

class _PartsSection extends StatelessWidget {
  final List<EvaluationSelectedPartEntity> parts;
  final bool isExpanded;
  final Duration animationDuration;
  final VoidCallback onToggleShowMore;

  const _PartsSection({
    required this.parts,
    required this.isExpanded,
    required this.animationDuration,
    required this.onToggleShowMore,
  });

  static const _dividerColor = Color(0xFFE7E7E7);

  @override
  Widget build(BuildContext context) {
    if (parts.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleParts = isExpanded || parts.length <= 1
        ? parts
        : parts.take(1).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Space.h16,
        const Divider(height: 1, color: _dividerColor),
        Space.h16,
        const TitleLargeText(text: 'قطعه', fontSize: 12),
        Space.h8,
        AnimatedSwitcher(
          duration: animationDuration,
          child: Column(
            key: ValueKey('${isExpanded}_${visibleParts.length}'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: visibleParts
                .map(
                  (part) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _SelectedLaborPartRow(part: part),
                  ),
                )
                .toList(),
          ),
        ),
        if (parts.length > 1) ...[
          Space.h8,
          _ShowMorePartsButton(isExpanded: isExpanded, onTap: onToggleShowMore),
        ],
      ],
    );
  }
}

class _ShowMorePartsButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const _ShowMorePartsButton({required this.isExpanded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BodyMediumText(
            text: isExpanded ? 'مشاهده کمتر' : 'مشاهده بیشتر',
            color: colorScheme.primary,
            fontSize: 12,
          ),
          Space.w4,
          AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.expand_more,
              size: 18,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LaborActionButtons extends StatelessWidget {
  final VoidCallback onAddPart;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _LaborActionButtons({
    required this.onAddPart,
    required this.onEdit,
    required this.onDelete,
  });

  static const double _compactBreakpoint = 300;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final buttons = [
      _LaborActionButton(
        title: 'افزودن قطعه',
        icon: Icons.add,
        color: colorScheme.outlineVariant,
        onTap: onAddPart,
      ),
      _LaborActionButton(
        title: 'ویرایش',
        icon: Icons.edit_outlined,
        color: colorScheme.onPrimaryFixed,
        onTap: onEdit,
      ),
      _LaborActionButton(
        title: 'حذف',
        icon: Icons.delete_outline,
        color: colorScheme.primary,
        onTap: onDelete,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _compactBreakpoint) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: buttons[0]),
                  Space.w8,
                  Expanded(child: buttons[1]),
                ],
              ),
              Space.h8,
              SizedBox(width: double.infinity, child: buttons[2]),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: buttons[0]),
            Space.w8,
            Expanded(child: buttons[1]),
            Space.w8,
            Expanded(child: buttons[2]),
          ],
        );
      },
    );
  }
}

class _LaborActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _LaborActionButton({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkwellButtonWidget(
      title: title,
      buttonPadding: 6,
      textStyle: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: color, fontSize: 12),
      height: 34,
      prefixIcon: Icon(icon, color: color, size: 14),
      titleColor: color,
      borderColor: color,
      backgroundColor: Colors.transparent,
      onTap: onTap,
    );
  }
}

class _SelectedLaborPartRow extends StatelessWidget {
  final EvaluationSelectedPartEntity part;

  const _SelectedLaborPartRow({required this.part});

  static const _leftSideWidthRatio = 0.65;
  static const _partNameWidthRatio = 0.45;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final leftSideMaxWidth = constraints.maxWidth * _leftSideWidthRatio;
        final partNameMaxWidth = constraints.maxWidth * _partNameWidthRatio;

        return Row(
          children: [
            SizedBox(
              width: leftSideMaxWidth,
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: partNameMaxWidth),
                    child: BodySmallText(
                      text: part.partName,
                      color: colorScheme.onPrimaryFixed,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  BodySmallText(
                    text: ' | تعداد: ${part.count}',
                    color: colorScheme.onPrimaryFixed,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const Spacer(),
            BodySmallText(
              text: part.price.toRialPrice(),
              color: colorScheme.onPrimaryFixed,
              textAlign: TextAlign.end,
              maxLines: 1,
            ),
          ],
        );
      },
    );
  }
}

extension RialPriceFormatter on num {
  String toRialPrice() {
    final value = toStringAsFixed(
      0,
    ).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');

    return '$value ریال';
  }
}
