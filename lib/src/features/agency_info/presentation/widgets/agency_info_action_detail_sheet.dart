import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_details_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionDetailSheet extends StatelessWidget {
  const AgencyInfoActionDetailSheet({
    super.key,
    required this.actionType,
    required this.item,
  });

  final AgencyInfoActionType actionType;
  final AgencyInfoEntity item;

  @override
  Widget build(BuildContext context) {
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
        const Divider(height: AppSize.s1),
        Expanded(
          child: AgencyInfoDetailsSection(item: item),
        ),
      ],
    );
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
        return 'نوع خدمات';
      case AgencyInfoActionType.complementaryInfo:
        return 'اطلاعات تکمیلی';
      case AgencyInfoActionType.history:
        return 'تاریخچه';
      case AgencyInfoActionType.delete:
        return 'حذف نمایندگی';
    }
  }
}
