import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:flutter/material.dart';

class VehicleInfoFormSection extends StatelessWidget {
  const VehicleInfoFormSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSize.s32,
                height: AppSize.s32,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
                child: Icon(
                  icon,
                  size: AppSize.s20,
                  color: theme.colorScheme.primary,
                ),
              ),
              Space.w8,
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Space.h20,
          ...children,
        ],
      ),
    );
  }
}
