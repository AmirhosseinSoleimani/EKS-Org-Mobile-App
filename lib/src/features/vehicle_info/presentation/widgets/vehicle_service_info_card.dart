import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/vehicle_license_plate_view.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class VehicleServiceInfoCard extends StatelessWidget {
  const VehicleServiceInfoCard({super.key, required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p14,
        AppPadding.p16,
        AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نوع وسیله نقلیه',
            textAlign: TextAlign.start,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF707070),
              fontWeight: FontWeight.w500,
            ),
          ),
          BodyMediumText(
            text:  item.title,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          Space.h12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.licensePlate?.trim().isNotEmpty == true)...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'شماره پلاک',
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF707070),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Space.h6,
                    VehicleLicensePlateView(licensePlate: item.licensePlate!),
                  ],)
              ],
              Space.w24,
              _CardInfoColumn(
                title: 'شماره شاسی',
                value: item.chassisNumber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardInfoColumn extends StatelessWidget {
  const _CardInfoColumn({
    required this.title,
    required this.value,
  });

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayValue = value?.trim().isNotEmpty == true ? value!.trim() : '---';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF707070),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          displayValue,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF202020),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
