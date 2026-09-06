import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuer_skill_certificates_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/submit_rescuer_skill_certificates_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/skill_certificates/rescuer_skill_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/skill_certificates/rescuer_skill_certificates_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/search_input_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_check_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RescuerSkillCertificatesSheet extends StatelessWidget {
  const RescuerSkillCertificatesSheet({
    super.key,
    required this.rescuer,
  });

  final RescuerEntity rescuer;

  @override
  Widget build(BuildContext context) {
    final personInfoId = rescuer.id;
    if (personInfoId == null) {
      return const _InvalidRescuerView();
    }

    return BlocProvider(
      create: (_) => RescuerSkillCertificatesCubit(
        getIt<GetRescuerSkillCertificatesUseCase>(),
        SubmitRescuerSkillCertificatesUseCase(getIt<RescuerRepository>()),
      )..load(personInfoId),
      child: _RescuerSkillCertificatesView(
        rescuer: rescuer,
        personInfoId: personInfoId,
      ),
    );
  }
}

class _RescuerSkillCertificatesView extends StatelessWidget {
  const _RescuerSkillCertificatesView({
    required this.rescuer,
    required this.personInfoId,
  });

  final RescuerEntity rescuer;
  final int personInfoId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RescuerSkillCertificatesCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<
          RescuerSkillCertificatesCubit,
          RescuerSkillCertificatesState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.message != current.message,
        listener: (context, state) {
          if (state.status == RescuerSkillCertificatesStatus.success) {
            Navigator.of(context).pop<String>(
              state.message ?? 'اطلاعات با موفقیت ثبت شد',
            );
            return;
          }

          if ((state.status == RescuerSkillCertificatesStatus.failure ||
                  state.status ==
                      RescuerSkillCertificatesStatus.connectionError) &&
              state.message?.isNotEmpty == true) {
            SnakeBarWidget.showError(
              context: context,
              message: state.message!,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: SimpleAppBar(
              title: 'گواهینامه مهارت ها',
              onBack: state.isSubmitting
                  ? () {}
                  : () => Navigator.of(context).pop<String>(),
            ),
            body: SafeArea(
              top: false,
              child: IgnorePointer(
                ignoring: state.isSubmitting,
                child: _buildBody(context, cubit, state),
              ),
            ),
            bottomNavigationBar: _SkillCertificateActions(
              isSubmitting: state.isSubmitting,
              isLoading: state.isLoading,
              onClose: () => Navigator.of(context).pop<String>(),
              onSubmit: () => cubit.submit(personInfoId),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    RescuerSkillCertificatesCubit cubit,
    RescuerSkillCertificatesState state,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if ((state.status == RescuerSkillCertificatesStatus.failure ||
            state.status == RescuerSkillCertificatesStatus.connectionError) &&
        state.items.isEmpty) {
      return _LoadErrorView(
        message: state.message ??
            'دریافت گواهینامه های مهارت با خطا مواجه شد.',
        onRetry: () => cubit.load(personInfoId),
      );
    }

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        _CertificateProfileCard(rescuer: rescuer),
        Space.h24,
        SearchInputField(
          controller: cubit.searchController,
          hintText: 'جستجوی مهارت',
          onChanged: cubit.onSearchChanged,
        ),
        Space.h16,
        _SelectAllTile(
          value: state.allSelected,
          enabled: !state.isSubmitting && state.items.isNotEmpty,
          onChanged: cubit.setAll,
        ),
        Space.h20,
        if (state.filteredItems.isEmpty)
          const EmptyListWidget()
        else
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                alignment: WrapAlignment.start,
                spacing: AppSize.s8,
                runSpacing: AppSize.s10,
                children: state.filteredItems.map((item) {
                  final enabled = item.id != null && !state.isSubmitting;
                  return InkWell(
                    onTap: enabled
                        ? () => cubit.toggleCertificate(item.id!)
                        : null,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    child: SelectableCheckItem(
                      title: _value(item.title),
                      selected: item.selectable == true,
                      enabled: enabled,
                      maxWidth: constraints.maxWidth,
                    ),
                  );
                }).toList(growable: false),
              );
            },
          ),
        Space.h24,
      ],
    );
  }
}

class _SelectAllTile extends StatelessWidget {
  const _SelectAllTile({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? () => onChanged(!value) : null,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: enabled
                  ? (checked) => onChanged(checked ?? false)
                  : null,
            ),
            Space.w8,
            const BodyMediumText(
              text: 'همه',
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillCertificateActions extends StatelessWidget {
  const _SkillCertificateActions({
    required this.isSubmitting,
    required this.isLoading,
    required this.onClose,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final bool isLoading;
  final VoidCallback onClose;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p28,
          AppPadding.p12,
          AppPadding.p28,
          AppPadding.p16,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withAlpha(24),
              blurRadius: AppSize.s10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: InkwellButtonWidget(
                title: 'ثبت',
                showLoading: isSubmitting,
                backgroundColor: theme.colorScheme.primary,
                onTap: () {
                  if (isSubmitting || isLoading) return;
                  onSubmit();
                },
              ),
            ),
            Space.w12,
            Expanded(
              child: InkwellButtonWidget(
                title: 'بستن',
                backgroundColor: theme.colorScheme.onPrimary,
                titleColor: theme.colorScheme.onSurfaceVariant,
                borderColor: theme.dividerColor,
                borderWidth: AppSize.s1,
                onTap: () {
                  if (isSubmitting) return;
                  onClose();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadErrorView extends StatelessWidget {
  const _LoadErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Theme.of(context).colorScheme.error,
              size: AppSize.s40,
            ),
            Space.h16,
            BodyMediumText(text: message, textAlign: TextAlign.center),
            Space.h16,
            InkwellButtonWidget(
              title: 'تلاش مجدد',
              width: AppSize.s150,
              onTap: onRetry,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _InvalidRescuerView extends StatelessWidget {
  const _InvalidRescuerView();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: SimpleAppBar(
          title: 'گواهینامه مهارت ها',
          onBack: () => Navigator.of(context).pop<String>(),
        ),
        body: const Center(
          child: BodyMediumText(
            text: 'شناسه امدادرسان معتبر نیست.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _CertificateProfileCard extends StatelessWidget {
  const _CertificateProfileCard({required this.rescuer});

  final RescuerEntity rescuer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = rescuer.isActive == true || rescuer.status == 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: AppSize.s18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSize.s48,
            height: AppSize.s48,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: theme.colorScheme.primary,
            ),
          ),
          Space.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyMediumText(
                  text: rescuer.fullName.isEmpty
                      ? 'بدون نام'
                      : rescuer.fullName,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                Space.h4,
                BodySmallText(
                  text: 'کد پرسنلی: ${_value(rescuer.code)}',
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          _StatusBadge(isActive: isActive),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFE4F8EC)
            : const Color(0xFFFFECEC),
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: BodySmallText(
        text: isActive ? 'فعال' : 'غیرفعال',
        color: isActive ? const Color(0xFF16A05D) : Colors.red,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

String _value(String? value) {
  final result = value?.trim();
  return result == null || result.isEmpty ? '-' : result;
}
