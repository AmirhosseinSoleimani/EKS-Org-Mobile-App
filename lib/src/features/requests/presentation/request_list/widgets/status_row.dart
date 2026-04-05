import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/status_widget/status_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class StatusRow extends StatelessWidget {
  final RequestEntity item;
  final MainAxisAlignment? mainAxisAlignment;

  const StatusRow({super.key,
    required this.item,
     this.mainAxisAlignment = MainAxisAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: mainAxisAlignment!,
      children: [
        StatusWidget(
          text: (item.hasSubscription ?? false) ? 'مشترک' : 'غیرمشترک',
          color: (item.hasSubscription ?? false)
              ? colorScheme.primary
              : colorScheme.error,
        ),
        const SizedBox(width: AppSize.s8),
        StatusWidget(
          text: (item.isGuaranty ?? false) ? 'دارای گارانتی' : 'فاقد گارانتی',
          color: (item.isGuaranty ?? false)
              ? colorScheme.primary
              : colorScheme.error,
        ),
      ],
    );
  }
}