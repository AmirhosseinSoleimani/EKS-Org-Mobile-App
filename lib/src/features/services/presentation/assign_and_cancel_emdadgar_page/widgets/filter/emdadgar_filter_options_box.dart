import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/filter/filter_check_box_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmdadgarFilterOptionsBox extends StatelessWidget {
  final AssignAndCancelEmdadgarCubit cubit;

  const EmdadgarFilterOptionsBox({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final serviceType =
        cubit.selectedRequest?.serviceType ?? ServiceType.reliefService;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s12,
        vertical: AppSize.s10,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withAlpha(90),
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(color: colorScheme.onInverseSurface, width: 1),
      ),
      child: Column(
        children: [
          FilterCheckboxRow(
            title: 'امداد رسان های مستقر در استان درخواست',
            notifier: cubit.requestProvinceEmdadgar,
            serviceType: serviceType,
          ),
          FilterCheckboxRow(
            title: 'امداد رسان های مستقر در شهر درخواست',
            notifier: cubit.requestCityEmdadgar,
            serviceType: serviceType,
          ),
          FilterCheckboxRow(
            title: 'امداد رسان های آزاد',
            notifier: cubit.onlyReadyEmdadgar,
            serviceType: serviceType,
          ),
          FilterCheckboxRow(
            title: 'امداد رسان های دارای محدودیت',
            notifier: cubit.limitedEmdadgar,
            serviceType: serviceType,
          ),
        ],
      ),
    );
  }
}
