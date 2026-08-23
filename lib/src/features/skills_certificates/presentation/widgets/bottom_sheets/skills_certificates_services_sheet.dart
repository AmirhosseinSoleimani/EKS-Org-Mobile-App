import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/utils/skill_service_type_ui.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_list_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selected_items_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_select_all_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_tabs.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsCertificatesServicesSheet extends StatefulWidget {
  const SkillsCertificatesServicesSheet({super.key});

  @override
  State<SkillsCertificatesServicesSheet> createState() =>
      _SkillsCertificatesServicesSheetState();
}

class _SkillsCertificatesServicesSheetState
    extends State<SkillsCertificatesServicesSheet> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedType;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: ColoredBox(
          color: theme.colorScheme.surface,
          child: Column(
            children: [
              FullScreenBottomSheetAppBar(
                title: 'سرویس ها',
                onClose: () {
                  if (cubit.state.data.isServicesSubmitting) return;
                  Navigator.of(context).pop<bool>(false);
                },
              ),
              Expanded(
                child: BlocBuilder<SkillsCertificatesCubit,
                    SkillsCertificatesState>(
                  builder: (context, state) {
                    final data = state.data;
                    if (data.isServicesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final groups = groupSkillServicesByType(data.services);
                    final activeGroup = groups.isEmpty
                        ? null
                        : _resolveActiveGroup(groups);
                    final selectedServices = data.services
                        .where(
                          (service) =>
                              service.id != null &&
                              data.selectedServiceIds.contains(service.id),
                        )
                        .toList(growable: false);

                    return ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p16,
                        AppPadding.p16,
                        AppPadding.p16,
                        AppPadding.p24,
                      ),
                      children: [
                        if (data.selectedSkill != null) ...[
                          SkillCertificateServicesHeader(data.selectedSkill!),
                          Space.h24,
                        ],
                        if (selectedServices.isNotEmpty) ...[
                          SelectedItemsSection<SkillServiceEntity>(
                            title: 'سرویس های انتخاب شده',
                            items: selectedServices,
                            itemTitle: (service) => service.displayTitle,
                            onRemove: data.isServicesSubmitting
                                ? null
                                : cubit.toggleService,
                          ),
                          Space.h24,
                        ],
                        if (groups.isEmpty)
                          const _ServicesEmptyMessage(
                            message: 'سرویسی برای نمایش وجود ندارد.',
                          )
                        else ...[
                          SelectionTabs<int>(
                            tabs: groups
                                .map(
                                  (group) => SelectionTab<int>(
                                    value: group.type,
                                    title: group.title,
                                  ),
                                )
                                .toList(growable: false),
                            selectedValue: activeGroup!.type,
                            onChanged: (value) {
                              setState(() => _selectedType = value);
                            },
                          ),
                          Space.h24,
                          SearchInputField(
                            controller: _searchController,
                            hintText: 'جستجو',
                            onChanged: cubit.filterServices,
                          ),
                          Space.h16,
                          SelectionSelectAllTile(
                            value: cubit.areServicesSelected(
                              activeGroup!.services,
                            ),
                            enabled: !data.isServicesSubmitting,
                            onChanged: (selected) =>
                                cubit.setServicesSelection(
                              activeGroup!.services,
                              selected,
                            ),
                          ),
                          Space.h12,
                          _ServicesList(
                            services: _filterServices(
                              activeGroup!.services,
                              data.serviceSearchText,
                            ),
                            emptyMessage: data.serviceSearchText.trim().isEmpty
                                ? 'سرویسی در این دسته وجود ندارد.'
                                : 'سرویسی با این عنوان پیدا نشد.',
                            selectedServiceIds: data.selectedServiceIds,
                            enabled: !data.isServicesSubmitting,
                            onToggle: cubit.toggleService,
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
              _ServicesActions(cubit: cubit),
            ],
          ),
        ),
      ),
    );
  }

  SkillServiceTypeGroup _resolveActiveGroup(
    List<SkillServiceTypeGroup> groups,
  ) {
    final selectedType = _selectedType;
    if (selectedType != null) {
      for (final group in groups) {
        if (group.type == selectedType) return group;
      }
    }
    return groups.firstWhere(
      (group) => group.services.isNotEmpty,
      orElse: () => groups.first,
    );
  }

  List<SkillServiceEntity> _filterServices(
    List<SkillServiceEntity> services,
    String query,
  ) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return services;

    return services
        .where(
          (service) =>
              service.displayTitle.toLowerCase().contains(normalizedQuery),
        )
        .toList(growable: false);
  }
}

class SkillCertificateServicesHeader extends StatelessWidget {
  const SkillCertificateServicesHeader(this.skill, {super.key});

  final SkillCertificateEntity skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: AppSize.s16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSize.s54,
            height: AppSize.s54,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium_outlined,
              color: colorScheme.primary,
              size: AppSize.s28,
            ),
          ),
          Space.w12,
          Expanded(
            child: Text(
              skill.displayTitle,
              textAlign: TextAlign.start,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Space.w12,
          StatusLabel(
            text: skill.isActive ? 'فعال' : 'غیرفعال',
            color: skill.isActive ? colorScheme.onError : colorScheme.error,
            variant: StatusLabelVariant.filledWithoutBorder,
          ),
        ],
      ),
    );
  }
}

class _ServicesList extends StatelessWidget {
  const _ServicesList({
    required this.services,
    required this.emptyMessage,
    required this.selectedServiceIds,
    required this.enabled,
    required this.onToggle,
  });

  final List<SkillServiceEntity> services;
  final String emptyMessage;
  final Set<int> selectedServiceIds;
  final bool enabled;
  final ValueChanged<SkillServiceEntity> onToggle;

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return _ServicesEmptyMessage(message: emptyMessage);
    }

    return Column(
      children: services
          .map(
            (service) => Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p8),
              child: SelectableListItem(
                title: service.displayTitle,
                selected: service.id != null &&
                    selectedServiceIds.contains(service.id),
                enabled: enabled,
                onTap: () => onToggle(service),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _ServicesEmptyMessage extends StatelessWidget {
  const _ServicesEmptyMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _ServicesActions extends StatelessWidget {
  const _ServicesActions({required this.cubit});

  final SkillsCertificatesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
      buildWhen: (previous, current) =>
          previous.data.isServicesSubmitting !=
          current.data.isServicesSubmitting,
      builder: (context, state) {
        final isSubmitting = state.data.isServicesSubmitting;

        return StickyFormActionBar(
          submitTitle: 'ثبت',
          cancelTitle: 'انصراف',
          isSubmitting: isSubmitting,
          onCancel: () => Navigator.of(context).pop<bool>(false),
          onSubmit: () async {
            final submitted = await cubit.submitServices();
            if (submitted && context.mounted) {
              Navigator.of(context).pop<bool>(true);
            }
          },
        );
      },
    );
  }
}
