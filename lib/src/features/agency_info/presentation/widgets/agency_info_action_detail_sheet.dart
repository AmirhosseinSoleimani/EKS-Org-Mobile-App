import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_service_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_active_relief_workers_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_active_vehicles_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_change_status_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_complementary_info_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_contracts_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_delete_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_history_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_service_type_action_view.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionDetailSheet extends StatelessWidget {
  const AgencyInfoActionDetailSheet({
    super.key,
    required this.actionType,
    required this.item,
    this.actionData,
  });

  final AgencyInfoActionType actionType;
  final AgencyInfoEntity item;
  final Object? actionData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
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
              Expanded(
                child: Text(
                  _title(actionType),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
        Divider(
          height: AppSize.s1,
          color: theme.dividerColor,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppPadding.p16,
              AppPadding.p16,
              AppPadding.p16,
              0,
            ),
            child: _buildContent(),
          ),
        ),
        _AgencyInfoActionCloseButton(
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    switch (actionType) {
      case AgencyInfoActionType.contracts:
        return AgencyInfoContractsActionView(item: item);
      case AgencyInfoActionType.activeReliefWorkers:
        return AgencyInfoActiveReliefWorkersActionView(item: item);
      case AgencyInfoActionType.activeVehicles:
        return AgencyInfoActiveVehiclesActionView(item: item);
      case AgencyInfoActionType.changeStatus:
        return AgencyInfoChangeStatusActionView(item: item);
      case AgencyInfoActionType.serviceType:
        final serviceTypes = actionData is List<AgencyServiceTypeEntity>
            ? actionData! as List<AgencyServiceTypeEntity>
            : const <AgencyServiceTypeEntity>[];
        return AgencyInfoServiceTypeActionView(
          item: item,
          serviceTypes: serviceTypes,
        );
      case AgencyInfoActionType.complementaryInfo:
        return AgencyInfoComplementaryInfoActionView(item: item);
      case AgencyInfoActionType.history:
        final histories = actionData is List<AgencyHistoryEntity>
            ? actionData! as List<AgencyHistoryEntity>
            : const <AgencyHistoryEntity>[];
        return AgencyInfoHistoryActionView(
          item: item,
          histories: histories,
        );
      case AgencyInfoActionType.delete:
        return AgencyInfoDeleteActionView(item: item);
    }
  }

  String _title(AgencyInfoActionType actionType) {
    switch (actionType) {
      case AgencyInfoActionType.contracts:
        return 'قراردادها';
      case AgencyInfoActionType.activeReliefWorkers:
        return 'امدادرسان‌های فعلی';
      case AgencyInfoActionType.activeVehicles:
        return 'خودروهای فعلی';
      case AgencyInfoActionType.changeStatus:
        return 'تغییر وضعیت';
      case AgencyInfoActionType.serviceType:
        return 'خدمات';
      case AgencyInfoActionType.complementaryInfo:
        return 'اطلاعات تکمیلی';
      case AgencyInfoActionType.history:
        return 'تاریخچه';
      case AgencyInfoActionType.delete:
        return 'حذف نمایندگی';
    }
  }
}

class _AgencyInfoActionCloseButton extends StatelessWidget {
  const _AgencyInfoActionCloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p12,
        AppPadding.p16,
        AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s16,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: InkwellButtonWidget(
          title: 'بستن',
          backgroundColor: theme.colorScheme.onPrimary,
          borderColor: theme.colorScheme.outline,
          titleColor: theme.colorScheme.onSurface,
          borderWidth: AppSize.s1,
          onTap: onTap,
        ),
      ),
    );
  }
}
