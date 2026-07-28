import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/services/service_selection_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavganServicesPage extends StatelessWidget {
  static const path = '/navgan-services-page';
  static const name = 'navgan-services-page';

  const NavganServicesPage({
    super.key,
    required this.navgan,
  });

  final NavganEntity navgan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NavganCubit>()..prepareServiceSheet(navgan),
      child: const _NavganServicesView(),
    );
  }
}

class _NavganServicesView extends StatelessWidget {
  const _NavganServicesView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavganCubit>();

    return BlocConsumer<NavganCubit, NavganState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        final error = state.errorMessage;
        if (error?.trim().isNotEmpty == true) {
          SnakeBarWidget.showError(context: context, message: error!);
        }

        final success = state.successMessage;
        if (success?.trim().isNotEmpty == true) {
          SnakeBarWidget.showSuccess(context: context, message: success!);
        }
      },
      builder: (context, state) {
        return ServiceSelectionPage<NavganServiceGroupEntity,
            EmdadServiceCategoryEntity>(
          title: 'سرویس‌ها',
          header: _NavganServiceHeader(navgan: state.selectedNavgan),
          groups: state.serviceGroups,
          groupTitle: (group) => group.serviceTypeTitle ?? '---',
          groupItems: (group) => group.emdadCategories,
          itemTitle: (item) => item.title ?? '---',
          itemSelected: (item) => item.selected,
          onItemToggle: cubit.toggleServiceCategory,
          isLoading: state.isServiceGroupsLoading,
          isSubmitting: state.isServicesSubmitting,
          onSubmit: () async {
            final success = await cubit.submitServiceCategories();
            if (success && context.mounted) context.pop(true);
          },
          onCancel: () => context.pop(),
        );
      },
    );
  }
}

class _NavganServiceHeader extends StatelessWidget {
  const _NavganServiceHeader({required this.navgan});

  final NavganEntity? navgan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: AppSize.s28,
            backgroundColor: theme.colorScheme.primary.withAlpha(25),
            child: Icon(
              Icons.commute,
              color: theme.colorScheme.primary,
            ),
          ),
          Space.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  navgan?.title?.trim().isNotEmpty == true
                      ? navgan!.title!.trim()
                      : '---',
                  textAlign: TextAlign.right,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.h6,
                Text(
                  'کد ناوگان: ${navgan?.code ?? '---'}',
                  textAlign: TextAlign.right,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Space.w12,
          StatusLabel(
            text: navgan?.isActive == true ? 'فعال' : 'غیرفعال',
            color: navgan?.isActive == true
                ? theme.colorScheme.onError
                : theme.colorScheme.error,
            variant: StatusLabelVariant.filledWithoutBorder,
          ),

        ],
      ),
    );
  }
}
