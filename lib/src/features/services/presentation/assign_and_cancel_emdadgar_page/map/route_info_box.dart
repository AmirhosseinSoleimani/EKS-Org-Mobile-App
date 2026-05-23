import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class RouteInfoBox extends StatelessWidget {
  final RouteEntity route;

  const RouteInfoBox({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(90),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _RouteInfoItem(
              icon: Icons.route,
              title: 'مسافت',
              value: route.distance.text,
            ),
          ),
          Container(width: 1, height: 32, color: const Color(0xffE5E7EB)),
          Expanded(
            child: _RouteInfoItem(
              icon: Icons.schedule,
              title: 'زمان',
              value: route.duration.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _RouteInfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: AppSize.s20, color: const Color(0xff6B7280)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xff6B7280),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xff111827),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
