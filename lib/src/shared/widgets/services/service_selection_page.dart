import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:flutter/material.dart';

class ServiceSelectionPage<TGroup, TItem> extends StatelessWidget {
  const ServiceSelectionPage({
    super.key,
    required this.title,
    required this.groups,
    required this.groupTitle,
    required this.groupItems,
    required this.itemTitle,
    required this.itemSelected,
    required this.onItemToggle,
    required this.onSubmit,
    required this.onCancel,
    this.header,
    this.isLoading = false,
    this.isSubmitting = false,
    this.emptyMessage = 'سرویسی برای نمایش وجود ندارد.',
  });

  final String title;
  final List<TGroup> groups;
  final String Function(TGroup group) groupTitle;
  final List<TItem> Function(TGroup group) groupItems;
  final String Function(TItem item) itemTitle;
  final bool Function(TItem item) itemSelected;
  final ValueChanged<TItem> onItemToggle;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final Widget? header;
  final bool isLoading;
  final bool isSubmitting;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedItems = groups
        .expand(groupItems)
        .where(itemSelected)
        .toList(growable: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: SimpleActionBar(title: title, onBack: onCancel),
        body: SafeArea(
          top: false,
          child: isLoading
              ? const Center(child: LoadingWidget())
              : groups.isEmpty
                  ? Center(
                      child: Text(
                        emptyMessage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p16,
                        AppPadding.p12,
                        AppPadding.p16,
                        AppPadding.p100,
                      ),
                      children: [
                        if (header != null) ...[
                          header!,
                          Space.h20,
                        ],
                        if (selectedItems.isNotEmpty) ...[
                          _SelectedServices<TItem>(
                            items: selectedItems,
                            itemTitle: itemTitle,
                            onRemove: onItemToggle,
                          ),
                          Space.h16,
                        ],
                        ...groups.map(
                          (group) => _ServiceGroup<TItem>(
                            title: groupTitle(group),
                            items: groupItems(group),
                            itemTitle: itemTitle,
                            itemSelected: itemSelected,
                            onItemToggle: onItemToggle,
                          ),
                        ),
                      ],
                    ),
        ),
        bottomNavigationBar: StickyFormActionBar(
          submitTitle: 'ثبت',
          cancelTitle: 'انصراف',
          isSubmitting: isSubmitting,
          onSubmit: onSubmit,
          onCancel: onCancel,
        ),
      ),
    );
  }
}

class _SelectedServices<TItem> extends StatelessWidget {
  const _SelectedServices({
    required this.items,
    required this.itemTitle,
    required this.onRemove,
  });

  final List<TItem> items;
  final String Function(TItem item) itemTitle;
  final ValueChanged<TItem> onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: theme.colorScheme.primary,
              size: AppSize.s22,
            ),
            Space.w8,
            Text(
              'سرویس‌های انتخاب شده',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Space.h12,
        Wrap(
          spacing: AppPadding.p8,
          runSpacing: AppPadding.p8,
          children: items
              .map(
                (item) => InputChip(
                  label: Text(itemTitle(item)),
                  onDeleted: () => onRemove(item),
                  deleteIcon: const Icon(Icons.close_rounded, size: 18),
                  backgroundColor: theme.colorScheme.primary.withAlpha(35),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ServiceGroup<TItem> extends StatelessWidget {
  const _ServiceGroup({
    required this.title,
    required this.items,
    required this.itemTitle,
    required this.itemSelected,
    required this.onItemToggle,
  });

  final String title;
  final List<TItem> items;
  final String Function(TItem item) itemTitle;
  final bool Function(TItem item) itemSelected;
  final ValueChanged<TItem> onItemToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8,
                  vertical: AppPadding.p4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(AppSize.s4),
                ),
                child: Text(
                  '${items.length} مورد',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Space.h8,
          Divider(color: theme.colorScheme.primary.withAlpha(80), height: 1),
          Space.h12,
          if (items.isEmpty)
            _EmptyGroup(title: 'سرویسی برای این گروه وجود ندارد.')
          else
            ...items.map(
              (item) => _ServiceTile(
                title: itemTitle(item),
                selected: itemSelected(item),
                onTap: () => onItemToggle(item),
              ),
            ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: Material(
        color: selected ? selectedColor.withAlpha(25) : theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Container(
            height: AppSize.s54,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p14,
              vertical: AppPadding.p10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s8),
              border: Border.all(
                color: selected ? selectedColor.withAlpha(120) : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                _SelectionBox(selected: selected),
                Space.w12,
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selected
                          ? selectedColor
                          : theme.colorScheme.onSurface,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                Space.w8,
                Icon(
                  _iconForTitle(title),
                  size: AppSize.s22,
                  color: selected
                      ? selectedColor
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconForTitle(String title) {
    if (title.contains('روغن')) return Icons.oil_barrel_outlined;
    if (title.contains('حمل')) return Icons.local_shipping_outlined;
    if (title.contains('بازدید')) return Icons.search_rounded;
    if (title.contains('رنگ') || title.contains('بدنه')) {
      return Icons.fact_check_outlined;
    }
    if (title.contains('فراخوان')) return Icons.campaign_outlined;
    if (title.contains('لوازم')) return Icons.grid_view_rounded;
    if (title.contains('ادوار')) return Icons.event_note_outlined;
    return Icons.miscellaneous_services_outlined;
  }
}

class _SelectionBox extends StatelessWidget {
  const _SelectionBox({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: AppSize.s24,
      height: AppSize.s24,
      decoration: BoxDecoration(
        color: selected ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSize.s6),
        border: Border.all(color: color),
      ),
      child: selected
          ? const Icon(
              Icons.check_rounded,
              size: AppSize.s18,
              color: Colors.white,
            )
          : null,
    );
  }
}

class _EmptyGroup extends StatelessWidget {
  const _EmptyGroup({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
