import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AddAgencyFormSection extends StatelessWidget {
  const AddAgencyFormSection({
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p18,
        AppPadding.p16,
        AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Space.w8,
              Icon(
                icon,
                color: theme.colorScheme.primary,
                size: AppSize.s22,
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
