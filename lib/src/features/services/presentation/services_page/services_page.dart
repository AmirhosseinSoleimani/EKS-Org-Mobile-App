import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/home_service_request_list_page/home_service_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/relief_request_list_page.dart';
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
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: AppSize.s18,
        mainAxisSpacing: AppSize.s18,
        padding: const EdgeInsets.all(AppPadding.p16),
        children: [
          /// امدادی
          GestureDetector(
            onTap: () => context.pushNamed(ReliefRequestListPage.name),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ServiceIconWidget(
                  backgroundColor: ServiceType.reliefService.serviceColor,
                  iconColor: colorScheme.onPrimary,
                  icon: Icons.car_repair,
                ),
                Space.h16,
                const BodyMediumText(
                  text: "درخواست های امدادی",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () => context.pushNamed(HomeServiceRequestListPage.name),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ServiceIconWidget(
                  backgroundColor: ServiceType.homeService.serviceColor,
                  iconColor: colorScheme.onPrimary,
                  icon: Icons.home_repair_service,
                ),
                Space.h16,
                const BodyMediumText(
                  text: "درخواست های خدمت در محل",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
