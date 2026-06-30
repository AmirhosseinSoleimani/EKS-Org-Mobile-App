import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
class RouteInfoBox extends StatelessWidget {
  final RouteEntity route;

  const RouteInfoBox({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isVerySmall = constraints.maxWidth < 260;

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
          child: isVerySmall
              ? _compactColumn()
              : _rowLayout(),
        );
      },
    );
  }

  Widget _rowLayout() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: _RouteInfoItem(
              icon: Icons.route,
              title: 'مسافت',
              value: route.distance.text,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(width: 1, height: 32, color: const Color(0xffE5E7EB)),
        const SizedBox(height: 12),
        Expanded(
          child: Center(
            child: _RouteInfoItem(
              icon: Icons.schedule,
              title: 'زمان',
              value: route.duration.text,
            ),
          ),
        ),
      ],
    );
  }

  Widget _compactColumn() {
    return Column(
      children: [
        _RouteInfoItem(
          icon: Icons.route,
          title: 'مسافت',
          value: route.distance.text,
        ),
        const SizedBox(height: 8),
        Container(height: 1, color: const Color(0xffE5E7EB)),
        const SizedBox(height: 8),
        _RouteInfoItem(
          icon: Icons.schedule,
          title: 'زمان',
          value: route.duration.text,
        ),
      ],
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.maxWidth < 190;

        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: isTight ? 16 : AppSize.s20,
                color: const Color(0xff6B7280),
              ),
              const SizedBox(width: 6),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: isTight ? 10 : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff111827),
                      fontSize: isTight ? 12 : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
