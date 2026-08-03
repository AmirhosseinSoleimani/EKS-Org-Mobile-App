import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SelectedItemsSection<T> extends StatefulWidget {
  const SelectedItemsSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemTitle,
    this.onRemove,
    this.collapsedItemCount = 4,
    this.hideWhenEmpty = true,
    this.chipColor = const Color(0xFFD8E9FF),
  }) : assert(collapsedItemCount > 0);

  final String title;
  final List<T> items;
  final String Function(T item) itemTitle;
  final ValueChanged<T>? onRemove;
  final int collapsedItemCount;
  final bool hideWhenEmpty;
  final Color chipColor;

  @override
  State<SelectedItemsSection<T>> createState() =>
      _SelectedItemsSectionState<T>();
}

class _SelectedItemsSectionState<T> extends State<SelectedItemsSection<T>> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && widget.hideWhenEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final canExpand = widget.items.length > widget.collapsedItemCount;
    final visibleItems = _isExpanded || !canExpand
        ? widget.items
        : widget.items
            .take(widget.collapsedItemCount)
            .toList(growable: false);

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
            Expanded(
              child: Text(
                widget.title,
                textAlign: TextAlign.start,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        if (visibleItems.isNotEmpty) ...[
          Space.h12,
          Wrap(
            alignment: WrapAlignment.start,
            spacing: AppPadding.p8,
            runSpacing: AppPadding.p8,
            children: visibleItems
                .map(
                  (item) => _SelectedItemChip(
                    title: widget.itemTitle(item),
                    color: widget.chipColor,
                    onRemove: widget.onRemove == null
                        ? null
                        : () => widget.onRemove!(item),
                  ),
                )
                .toList(growable: false),
          ),
        ],
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
                    size: AppSize.s18,
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

class _SelectedItemChip extends StatelessWidget {
  const _SelectedItemChip({
    required this.title,
    required this.color,
    this.onRemove,
  });

  final String title;
  final Color color;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width - (AppPadding.p16 * 2),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            AppPadding.p12,
            AppPadding.p8,
            onRemove == null ? AppPadding.p12 : AppPadding.p8,
            AppPadding.p8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF222222),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (onRemove != null) ...[
                Space.w8,
                InkResponse(
                  onTap: onRemove,
                  radius: AppSize.s18,
                  child: const Padding(
                    padding: EdgeInsets.all(AppPadding.p2),
                    child: Icon(
                      Icons.close_rounded,
                      size: AppSize.s18,
                      color: Color(0xFF222222),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
