import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsCertificatesBottomSheets {
  static void showFilterSheet({
    required BuildContext context,
    required SkillsCertificatesCubit cubit,
  }) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _FilterSheet(),
      ),
    );
  }

  static Future<void> showFormSheet({
    required BuildContext context,
    required SkillsCertificatesCubit cubit,
    SkillCertificateEntity? skill,
  }) async {
    final initialSkill = skill?.id == null ? skill : await cubit.getSkillById(skill!.id!);
    if (skill != null && initialSkill == null) return;
    if (!context.mounted) return;

    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: _SkillFormSheet(skill: initialSkill),
      ),
    );
  }

  static Future<void> showServicesSheet({
    required BuildContext context,
    required SkillsCertificatesCubit cubit,
    required SkillCertificateEntity skill,
  }) async {
    await cubit.loadServices(skill);
    if (!context.mounted) return;

    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _ServicesSheet(),
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet();

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  int activeFilter = -1;

  @override
  void initState() {
    super.initState();
    final value = context.read<SkillsCertificatesCubit>().state.data.activeFilter;
    activeFilter = value == null ? -1 : value ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          bottomInset + AppPadding.p16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('فیلترها', style: Theme.of(context).textTheme.titleMedium),
            Space.h16,
            TextField(
              controller: cubit.titleFilterController,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'عنوان',
                counterText: '',
              ),
            ),
            Space.h12,
            DropdownButtonFormField<int>(
              value: activeFilter,
              decoration: const InputDecoration(labelText: 'وضعیت'),
              items: const [
                DropdownMenuItem(value: -1, child: Text('همه')),
                DropdownMenuItem(value: 1, child: Text('فعال')),
                DropdownMenuItem(value: 0, child: Text('غیرفعال')),
              ],
              onChanged: (value) => setState(() => activeFilter = value ?? -1),
            ),
            Space.h20,
            Row(
              children: [
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'اعمال فیلتر',
                    onTap: () {
                      cubit.changeActiveFilter(
                        activeFilter == -1 ? null : activeFilter == 1,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Space.w12,
                Expanded(
                  child: InkwellButtonWidget(
                    backgroundColor: Colors.transparent,
                    titleColor: colorScheme.onTertiaryFixed,
                    title: 'پاک کردن فیلتر',
                    onTap: () {
                      cubit.clearFilters();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillFormSheet extends StatefulWidget {
  final SkillCertificateEntity? skill;

  const _SkillFormSheet({this.skill});

  @override
  State<_SkillFormSheet> createState() => _SkillFormSheetState();
}

class _SkillFormSheetState extends State<_SkillFormSheet> {
  late final TextEditingController titleController;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.skill?.title ?? '');
    isActive = widget.skill?.isActive ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final isEdit = widget.skill?.id != null;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          bottomInset + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                  const Spacer(),
                  Text(
                    isEdit ? 'ویرایش گواهینامه' : 'ثبت‌ گواهینامه جدید',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Space.h16,
              TextField(
                controller: titleController,
                maxLength: 100,
                decoration: const InputDecoration(
                  labelText: 'عنوان *',
                  counterText: '',
                ),
              ),
              Space.h12,
              DropdownButtonFormField<bool>(
                value: isActive,
                decoration: const InputDecoration(labelText: 'وضعیت'),
                items: const [
                  DropdownMenuItem(value: true, child: Text('فعال')),
                  DropdownMenuItem(value: false, child: Text('غیر فعال')),
                ],
                onChanged: (value) => setState(() => isActive = value ?? false),
              ),
              Space.h24,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: isEdit ? 'ویرایش' : 'ثبت‌',
                      onTap: () async {
                        final saved = await cubit.saveSkill(
                          id: widget.skill?.id,
                          title: titleController.text,
                          isActive: isActive,
                        );
                        if (saved && context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('انصراف'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}

class _ServicesSheet extends StatelessWidget {
  const _ServicesSheet();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .92,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p12,
                AppPadding.p16,
                AppPadding.p8,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                  const Spacer(),
                  Text('سرویس‌ها', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
                builder: (context, state) {
                  final data = state.data;
                  final skill = data.selectedSkill;

                  if (data.isServicesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    children: [
                      if (skill != null) _SkillHeader(skill: skill),
                      Space.h16,
                      TextField(
                        onChanged: cubit.filterServices,
                        decoration: const InputDecoration(
                          hintText: 'جستجوی سرویس',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      Space.h16,
                      Wrap(
                        spacing: AppSize.s8,
                        runSpacing: AppSize.s8,
                        children: cubit.filteredServices
                            .map((item) => _ServiceChip(service: item))
                            .toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
                builder: (context, state) {
                  return InkwellButtonWidget(
                    title: state.data.isServicesSubmitting ? 'در حال ثبت...' : 'بستن',
                    backgroundColor: Colors.transparent,
                    titleColor: colorScheme.onSurface,
                    onTap: () async {
                      await cubit.submitServices();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillHeader extends StatelessWidget {
  final SkillCertificateEntity skill;

  const _SkillHeader({required this.skill});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSize.s48,
            height: AppSize.s48,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.desktop_windows_outlined, color: colorScheme.primary),
          ),
          Space.w12,
          Expanded(
            child: Text(
              skill.displayTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final SkillServiceEntity service;

  const _ServiceChip({required this.service});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SkillsCertificatesCubit, SkillsCertificatesState>(
      buildWhen: (previous, current) {
        return previous.data.selectedServiceIds != current.data.selectedServiceIds;
      },
      builder: (context, state) {
        final selected = service.id != null &&
            state.data.selectedServiceIds.contains(service.id);

        return InkWell(
          borderRadius: BorderRadius.circular(AppSize.s8),
          onTap: () => cubit.toggleService(service),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12,
              vertical: AppPadding.p12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSize.s8),
              border: Border.all(
                color: selected ? colorScheme.primary : colorScheme.outlineVariant,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text(service.displayTitle)),
                if (selected) ...[
                  Space.w8,
                  Icon(Icons.check_circle_outline, size: 18, color: colorScheme.primary),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
