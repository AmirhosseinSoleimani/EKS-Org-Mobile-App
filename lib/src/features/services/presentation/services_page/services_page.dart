import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/selected_service_page/selected_service_page.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/service_icon_widget.dart';

class ServicesPage extends StatelessWidget {
  static const path = "/services";
  static const name = "services";

  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const MainAppBar(title: 'خدمات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppPadding.p16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSize.s18,
          mainAxisSpacing: AppSize.s18,
        ),
        itemCount: ServiceType.values.length,
        itemBuilder: (context, index) {
          final (type) = ServiceType.values[index];
          return GestureDetector(
            onTap: () => context.pushNamed(
              SelectedServicesPage.name,
              extra: type,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ServiceIconWidget(
                  backgroundColor: type.serviceColor,
                  iconColor: colorScheme.onPrimary,
                  icon: type.icon,
                ),
                Space.h16,
                BodyMediumText(
                  text: "درخواست های ${type.label}",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
