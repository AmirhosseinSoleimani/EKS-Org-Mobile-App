import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_list_page.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/pages/leave_page.dart';
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
          final sunItems = <Widget>[
            if (access.canShowHomeServiceRequestsMenu())
              _SanItemWidget(
                title: 'مرخصی',
                icon: Icons.calendar_month,
                onTap: () => context.pushNamed(LeavePage.name),
              ),
            if (access.canShowHomeServiceRequestsMenu())
              _SanItemWidget(
                title: 'واحد امدادی',
                icon: Icons.local_shipping_outlined,
                onTap: () => context.pushNamed(EmdadUnitListPage.name),
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
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSize.s18,
                  mainAxisSpacing: AppSize.s18,
                  padding: const EdgeInsets.all(AppPadding.p16),
                  children: serviceItems,
                ),
                Space.h8,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'امور نمایندگی',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.outline
                    ),
                  ),
                ),
                Space.h16,
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: AppSize.s12,
                  mainAxisSpacing: AppSize.s10,
                  childAspectRatio: 1.1,
                  children: sunItems,
                ),
              ],
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


class _SanItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SanItemWidget({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12)),
          color: Theme.of(context).colorScheme.onInverseSurface
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: AppSize.s28,
                color: Theme.of(context).colorScheme.outline,
              ),
              Space.h8,
              Text(
                title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    fontSize: AppSize.s14
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
