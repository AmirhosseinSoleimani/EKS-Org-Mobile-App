import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/request_list_page.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestHistoryButton extends StatelessWidget {
  const RequestHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkwellButtonWidget(
      onTap: () => context.pushNamed(RequestListPage.name),
      borderColor: colorScheme.primary,
      backgroundColor: colorScheme.surface,
      titleColor: colorScheme.primary,
      prefixIcon: Icon(
        IconManager.history,
        size: AppSize.s20,
        color: colorScheme.primary,
      ),
      title: 'مشاهده تاریخچه درخواست‌ها',
    );
  }
}
