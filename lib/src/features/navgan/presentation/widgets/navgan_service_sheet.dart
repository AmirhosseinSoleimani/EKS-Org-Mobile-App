import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavganServiceSheet extends StatelessWidget {
  const NavganServiceSheet({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.onCancel,
  });

  final String title;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavganCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<NavganCubit, NavganState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.onPrimary,
            body: Column(
              children: [
                FullScreenBottomSheetAppBar(
                  title: title,
                  onClose: onCancel,
                ),
                Expanded(
                  child: SafeArea(
                    top: false,
                    child: state.isServiceGroupsLoading
                        ? const Center(child: LoadingWidget())
                        : ListView.separated(
                            padding: const EdgeInsets.all(AppPadding.p16),
                            itemCount: state.serviceGroups.length,
                            separatorBuilder: (_, __) => Space.h16,
                            itemBuilder: (context, index) {
                              final group = state.serviceGroups[index];
                              return _ServiceGroup(
                                title: group.serviceTypeTitle ?? '---',
                                items: group.emdadCategories,
                                onChanged: cubit.toggleServiceCategory,
                              );
                            },
                          ),
                    ),
                ),
              ],
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isServicesSubmitting,
              onSubmit: onSubmit,
              onCancel: onCancel,
            ),
          );
        },
      ),
    );
  }
}

class _ServiceGroup extends StatelessWidget {
  const _ServiceGroup({
    required this.title,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final List<EmdadServiceCategoryEntity> items;
  final ValueChanged<EmdadServiceCategoryEntity> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleLargeText(
            text: title,
            color: theme.colorScheme.onSurface,
            fontSize: AppSize.s16,
          ),
          Space.h12,
          if (items.isEmpty)
            BodySmallText(
              text: 'سرویسی برای این گروه وجود ندارد.',
              color: theme.colorScheme.onSurfaceVariant,
            )
          else
            ...items.map(
              (item) => AppCheckboxWidget(
                title: item.title ?? '---',
                value: item.selected,
                onChanged: (_) => onChanged(item),
              ),
            ),
        ],
      ),
    );
  }
}
