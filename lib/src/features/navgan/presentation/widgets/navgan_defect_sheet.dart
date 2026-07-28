import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavganDefectSheet extends StatelessWidget {
  const NavganDefectSheet({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

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
          final categories = state.serviceGroups
              .expand((group) => group.emdadCategories)
              .toList();
              return SizedBox();
        /*  return Scaffold(
            backgroundColor: theme.colorScheme.onPrimary,
            body: Column(
              children: [
                FullScreenBottomSheetAppBar(
                  title: 'ایرادات سرویس خودرو',
                  onClose: onCancel,
                ),
                Expanded(
                  child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (state.isServiceGroupsLoading)
                            const Center(child: LoadingWidget())
                          else
                            OverlayDropdownFormField<
                                EmdadServiceCategoryEntity>(
                              key: ValueKey(
                                'defect-service-${state.selectedServiceCategory?.id}-${categories.length}',
                              ),
                              labelText: 'سرویس',
                              items: categories,
                              value: state.selectedServiceCategory,
                              hintText: categories.isEmpty
                                  ? 'سرویسی وجود ندارد'
                                  : 'انتخاب کنید',
                              enabled: categories.isNotEmpty,
                              onChanged: cubit.selectDefectServiceCategory,
                            ),
                          Space.h20,
                          if (state.isDefectsLoading)
                            const Center(child: LoadingWidget())
                          else if (state.selectedServiceCategory == null)
                            BodySmallText(
                              text:
                                  'برای مشاهده ایرادات، سرویس را انتخاب کنید.',
                              color: theme.colorScheme.onSurfaceVariant,
                            )
                          else
                            _DefectList(
                              items: state.defects,
                              onChanged: cubit.toggleDefect,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isDefectsSubmitting,
              onSubmit: onSubmit,
              onCancel: onCancel,
            ),
          );*/
        },
      ),
    );
  }
}

class _DefectList extends StatelessWidget {
  const _DefectList({
    required this.items,
    required this.onChanged,
  });

  final List<NavganDefectEntity> items;
  final ValueChanged<NavganDefectEntity> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (items.isEmpty) {
      return BodySmallText(
        text: 'ایرادی برای این سرویس وجود ندارد.',
        color: colorScheme.onSurfaceVariant,
      );
    }

    return Column(
      children: items
          .map(
            (item) => AppCheckboxWidget(
              title: item.title ?? '---',
              value: item.selected,
              onChanged: (_) => onChanged(item),
            ),
          )
          .toList(),
    );
  }
}
