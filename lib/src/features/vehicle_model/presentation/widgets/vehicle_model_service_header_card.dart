import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';

class VehicleModelServiceHeaderCard extends StatelessWidget {
  const VehicleModelServiceHeaderCard({
    super.key,
    required this.item,
  });

  final VehicleModelEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
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
            width: AppSize.s54,
            height: AppSize.s54,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_car_outlined,
              color: colorScheme.primary,
              size: AppSize.s28,
            ),
          ),
          Space.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? item.title ?? '---',
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.h4,
                Text(
                  _subtitle,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Space.w12,
          StatusLabel(
            text: item.isActive == true ? 'فعال' : 'غیرفعال',
            color: item.isActive == true
                ? colorScheme.onError
                : colorScheme.error,
            variant: StatusLabelVariant.filledWithoutBorder,
          ),
        ],
      ),
    );
  }

  String get _subtitle {
    final values = <String>[
      if (item.code?.trim().isNotEmpty == true) 'کد: ${item.code!.trim()}',
      if (item.navganTypeTitle?.trim().isNotEmpty == true)
        item.navganTypeTitle!.trim(),
    ];
    return values.isEmpty ? '---' : values.join(' | ');
  }
}
