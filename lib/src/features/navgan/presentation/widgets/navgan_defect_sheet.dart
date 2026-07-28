import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavganDefectSheet extends StatefulWidget {
  const NavganDefectSheet({
    super.key,
    required this.onSuccess,
    required this.onCancel,
  });

  final VoidCallback onSuccess;
  final VoidCallback onCancel;

  @override
  State<NavganDefectSheet> createState() => _NavganDefectSheetState();
}

class _NavganDefectSheetState extends State<NavganDefectSheet> {
  final TextEditingController _searchController = TextEditingController();
  var _query = '';
  var _showAllSelected = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavganCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<NavganCubit, NavganState>(
        builder: (context, state) {
          final title = _value(state.selectedServiceCategory?.title);
          final selectedItems = state.committedDefects;
          final filteredItems = _filteredItems(state.defects);
          final allSelected = state.defects.isNotEmpty &&
              state.defects.every((item) => item.selected);

          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: Column(
              children: [
                _SheetHeader(
                  title: title,
                  onClose: widget.onCancel,
                ),
                Expanded(
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: state.isDefectsLoading
                        ? const Center(child: LoadingWidget())
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  AppPadding.p16,
                                  AppPadding.p16,
                                  AppPadding.p16,
                                  AppPadding.p8,
                                ),
                                child: _SelectedDefectsSummary(
                                  items: selectedItems,
                                  showAll: _showAllSelected,
                                  onShowMore: selectedItems.length <= 4
                                      ? null
                                      : () => setState(() {
                                            _showAllSelected =
                                                !_showAllSelected;
                                          }),
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                    AppPadding.p16,
                                    AppPadding.p12,
                                    AppPadding.p16,
                                    AppPadding.p24,
                                  ),
                                  children: [
                                    SearchInputField(
                                      controller: _searchController,
                                      hintText: 'جستجو',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      onChanged: (value) {
                                        setState(() => _query = value.trim());
                                      },
                                    ),
                                    Space.h16,
                                    AppCheckboxWidget(
                                      title: 'انتخاب همه',
                                      value: allSelected,
                                      onChanged: state.defects.isNotEmpty
                                          ? (value) =>
                                              cubit.setAllDefectsSelected(value)
                                          : (value) {},
                                    ),
                                    Space.h12,
                                    if (filteredItems.isEmpty)
                                      const EmptyListWidget()
                                    else
                                      ...filteredItems.map(
                                        (item) => _DefectTile(
                                          item: item,
                                          onTap: () =>
                                              cubit.toggleDefect(item),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isDefectsSubmitting,
              onSubmit: () => _submit(context, cubit),
              onCancel: state.isDefectsSubmitting ? null : widget.onCancel,
            ),
          );
        },
      ),
    );
  }

  List<NavganDefectEntity> _filteredItems(List<NavganDefectEntity> items) {
    if (_query.isEmpty) return items;
    return items.where((item) {
      return (item.title ?? '').contains(_query);
    }).toList();
  }

  Future<void> _submit(BuildContext context, NavganCubit cubit) async {
    final success = await cubit.submitDefects();
    if (!context.mounted) return;

    if (success) {
      widget.onSuccess();
      return;
    }

    final message = cubit.state.errorMessage ??
        'ثبت محدودیت‌ها با خطا مواجه شد.';
    await BottomSheetMessage.showError(
      context: context,
      data: BottomSheetMessageModel(
        title: 'خطا در ثبت',
        message: message,
      ),
      isDismissible: true,
      enableDrag: true,
      onButtonTap: () => Navigator.of(context).pop(),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({
    required this.title,
    required this.onClose,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Container(
        height: AppSize.s64,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            bottom: BorderSide(color: theme.dividerColor.withOpacity(0.7)),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onClose,
              splashRadius: AppSize.s22,
              icon: Icon(
                Icons.close_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Space.w8,
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s48),
          ],
        ),
      ),
    );
  }
}

class _SelectedDefectsSummary extends StatelessWidget {
  const _SelectedDefectsSummary({
    required this.items,
    required this.showAll,
    required this.onShowMore,
  });

  final List<NavganDefectEntity> items;
  final bool showAll;
  final VoidCallback? onShowMore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleItems = showAll ? items : items.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'ایرادات انتخاب شده',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Space.w8,
            Icon(
              Icons.check_circle_outline_rounded,
              color: theme.colorScheme.primary,
              size: AppSize.s22,
            ),
          ],
        ),
        if (visibleItems.isNotEmpty) ...[
          Space.h12,
          Wrap(
            spacing: AppPadding.p8,
            runSpacing: AppPadding.p8,
            children: visibleItems
                .map(
                  (item) =>
                  InputChip(
                    label: Text(
                      _value(item.title),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    onDeleted: null,
                    deleteIcon: Icon(
                      Icons.close_rounded,
                      size: AppSize.s18,
                      color: theme.colorScheme.onSurface,
                    ),
                    backgroundColor: const Color(0xFFCCE1FF),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                    ),
                  ),
            )
                .toList(),
          ),
        ],
        if (onShowMore != null) ...[
          Space.h12,
          TextButton.icon(
            onPressed: onShowMore,
            icon: Icon(
              showAll
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: AppSize.s20,
            ),
            label: Text(showAll ? 'مشاهده کمتر' : 'مشاهده بیشتر'),
          ),
        ],
      ],
    );
  }
}

class _DefectTile extends StatelessWidget {
  const _DefectTile({
    required this.item,
    required this.onTap,
  });

  final NavganDefectEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = item.selected;
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: Material(
        color: selected ? primary.withAlpha(20) : theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Container(
            height: AppSize.s60,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p14,
              vertical: AppPadding.p12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s8),
              border: Border.all(
                color: selected ? primary.withAlpha(80) : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _value(item.title),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selected ? primary : theme.colorScheme.onSurface,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                Space.w12,
                _SelectionBox(selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionBox extends StatelessWidget {
  const _SelectionBox({
    required this.selected,
    this.enabled = true,
  });

  final bool selected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final color = enabled ? primary : theme.colorScheme.onSurfaceVariant;

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
          ? Icon(
        Icons.check_rounded,
        size: AppSize.s18,
        color: theme.colorScheme.onPrimary,
      )
          : null,
    );
  }
}

String _value(String? value) {
  return value
      ?.trim()
      .isNotEmpty == true ? value!.trim() : '---';
}
