import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SelectedVehicleDefectsSection extends StatefulWidget {
  const SelectedVehicleDefectsSection({
    super.key,
    required this.items,
    required this.onRemove,
  });

  final List<EmdadServiceCategoryEntity> items;
  final ValueChanged<int> onRemove;

  @override
  State<SelectedVehicleDefectsSection> createState() =>
      _SelectedVehicleDefectsSectionState();
}

class _SelectedVehicleDefectsSectionState
    extends State<SelectedVehicleDefectsSection> {
  static const int _collapsedItemCount = 4;

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canExpand = widget.items.length > _collapsedItemCount;
    final visibleItems = _isExpanded || !canExpand
        ? widget.items
        : widget.items.take(_collapsedItemCount).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: AppSize.s20,
              color: theme.colorScheme.primary,
            ),
            Space.w8,
            Text(
              'ایرادات انتخاب شده',
              style: theme.textTheme.titleSmall?.copyWith(
                color: const Color(0xFF4A4A4A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Space.h12,
        if (widget.items.isEmpty)
          Text(
            'ایرادی برای این خودرو انتخاب نشده است.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF6B6B6B),
            ),
          )
        else
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: visibleItems
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.only(bottom: AppPadding.p8),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: _SelectedDefectChip(
                          category: category,
                          onRemove: () => widget.onRemove(category.id),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (canExpand) ...[
          Space.h4,
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_isExpanded ? 'مشاهده کمتر' : 'مشاهده بیشتر'),
                  Space.w4,
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SelectedDefectChip extends StatelessWidget {
  const _SelectedDefectChip({
    required this.category,
    required this.onRemove,
  });

  final EmdadServiceCategoryEntity category;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width - (AppPadding.p16 * 2),
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppPadding.p12,
        AppPadding.p8,
        AppPadding.p8,
        AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFD8E9FF),
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              category.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF222222),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Space.w8,
          InkResponse(
            onTap: onRemove,
            radius: 18,
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.close_rounded,
                size: 18,
                color: Color(0xFF222222),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
