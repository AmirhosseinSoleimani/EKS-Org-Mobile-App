import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bullet_point/bullet_point.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/stat_row_card/row_card.dart';
import 'package:flutter/material.dart';

class StatRowCard extends StatelessWidget {
  final String title;
  final String value;
  final ServiceType serviceType;

  const StatRowCard({
    super.key,
    required this.title,
    required this.value,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RowCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BulletPoint(color: serviceType.serviceColor),
          Space.w8,
          Expanded(
            child: Text(
              title,
              style: textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Space.w8,
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
