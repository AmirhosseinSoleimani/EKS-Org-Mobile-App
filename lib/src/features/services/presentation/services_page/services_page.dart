import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/home_service_request_list_page/home_service_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/relief_request_list_page.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/presentation/widgets/current_session_access_builder.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
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
    return Scaffold(
      appBar: const MainAppBar(title: 'خدمات'),
      body: CurrentSessionAccessBuilder(
        emptyBuilder: (context) {
          return const Center(
            child: BodyMediumText(
              text: 'اطلاعات نشست کاربر دریافت نشده است.',
              textAlign: TextAlign.center,
            ),
          );
        },
        builder: (context, access) {
          final colorScheme = Theme.of(context).colorScheme;

          final serviceItems = <Widget>[
            if (access.canShowServiceRequestSearchMenu())
              _ServicePageItem(
                title: 'درخواست های امدادی',
                backgroundColor: ServiceType.reliefService.serviceColor,
                iconColor: colorScheme.onPrimary,
                imagePath: ImageManager.emdadServece,
                onTap: () => context.pushNamed(ReliefRequestListPage.name),
              ),

            if (access.canShowHomeServiceRequestsMenu())
              _ServicePageItem(
                title: 'درخواست های خدمت در محل',
                backgroundColor: ServiceType.homeService.serviceColor,
                iconColor: colorScheme.onPrimary,
                imagePath: ImageManager.locationService,
                onTap: () => context.pushNamed(HomeServiceRequestListPage.name),
              ),
          ];

          if (serviceItems.isEmpty) {
            return const Center(
              child: BodyMediumText(
                text: 'شما دسترسی لازم برای مشاهده خدمات را ندارید.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8,
            ),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: AppSize.s18,
              mainAxisSpacing: AppSize.s18,
              padding: const EdgeInsets.all(AppPadding.p16),
              children: serviceItems,
            ),
          );
        },
      ),
    );
  }
}

class _ServicePageItem extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color iconColor;
  final String imagePath;
  final VoidCallback onTap;

  const _ServicePageItem({
    required this.title,
    required this.backgroundColor,
    required this.iconColor,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ServiceIconWidget(
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            imagePath: imagePath,
          ),
          Space.h16,
          BodyMediumText(
            text: title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
/*class ServicesPage extends StatelessWidget {
  static const path = "/services";
  static const name = "services";

  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MainAppBar(title: 'خدمات'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppSize.s18,
          mainAxisSpacing: AppSize.s18,
          padding: const EdgeInsets.all(AppPadding.p16),
          children: [
            GestureDetector(
              onTap: () => context.pushNamed(ReliefRequestListPage.name),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ServiceIconWidget(
                    backgroundColor: ServiceType.reliefService.serviceColor,
                    iconColor: colorScheme.onPrimary,
                    imagePath: ImageManager.emdadServece,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ServiceIconWidget(
                    backgroundColor: ServiceType.homeService.serviceColor,
                    iconColor: colorScheme.onPrimary,
                    imagePath: ImageManager.locationService,
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
      ),
    );
  }
}*/
