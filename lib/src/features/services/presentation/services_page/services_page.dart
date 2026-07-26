import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_info_list_page.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/cartable_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_list_page.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/pages/grade_pattern_list_page.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/pages/imei_page.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/pages/leave_page.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_page.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/rescuer_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/home_service_request_list_page/home_service_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/relief_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/pages/shift_list_page.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/skills_certificates_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_list_page.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/presentation/widgets/current_session_access_builder.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/service_icon_widget.dart';

class ServicesPage extends StatelessWidget {
  static const path = '/services';
  static const name = 'services';

  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'خدمات'),
      body: CurrentSessionAccessBuilder(
        emptyBuilder: (_) =>
        const _EmptyServicesMessage(
          message: 'اطلاعات نشست کاربر دریافت نشده است.',
        ),
        builder: (context, access) {
          final mainServices = <_MainServiceItemData>[
            if (access.canShowServiceRequestSearchMenu())
              _MainServiceItemData(
                title: 'درخواست‌های امدادی',
                backgroundColor: ServiceType.reliefService.serviceColor,
                imagePath: ImageManager.emdadServece,
                onTap: () {
                  context.pushNamed(ReliefRequestListPage.name);
                },
              ),
            if (access.canShowHomeServiceRequestsMenu())
              _MainServiceItemData(
                title: 'درخواست‌های خدمت در محل',
                backgroundColor: ServiceType.homeService.serviceColor,
                imagePath: ImageManager.locationService,
                onTap: () {
                  context.pushNamed(HomeServiceRequestListPage.name);
                },
              ),
          ];

          final agencyServices = <_AgencyServiceItemData>[
            if (access.canShowHomeServiceRequestsMenu())
              _AgencyServiceItemData(
                title: 'برنامه‌ریزی',
                icon: Icons.calendar_month_outlined,
                onTap: () {
                  context.pushNamed(PlanInfoPage.name);
                },
              ),
            if (access.canShowHomeServiceRequestsMenu())
              _AgencyServiceItemData(
                title: 'خودروی امدادی',
                icon: Icons.local_shipping_outlined,
                onTap: () {
                  context.pushNamed(VehicleInfoListPage.name);
                },
              ),
            if (access.canShowHomeServiceRequestsMenu())
              _AgencyServiceItemData(
                title: 'واحد امدادی',
                icon: Icons.groups_outlined,
                onTap: () {
                  context.pushNamed(EmdadUnitListPage.name);
                },
              ),
            if (access.canShowHomeServiceRequestsMenu())
              _AgencyServiceItemData(
                title: 'مرخصی‌ها',
                icon: Icons.event_busy_outlined,
                onTap: () {
                  context.pushNamed(LeavePage.name);
                },
              ),
            if (access.canShowHomeServiceRequestsMenu())
              _AgencyServiceItemData(
                title: 'الگوی گرید',
                icon: Icons.grading_outlined,
                onTap: () {
                  context.pushNamed(GradePatternListPage.name);
                },
              ),
            if (access.canShowHomeServiceRequestsMenu())
              _AgencyServiceItemData(
                title: 'نمایندگی',
                icon: Icons.storefront_outlined,
                onTap: () {
                  context.pushNamed(AgencyInfoListPage.name);
                },
              ),

            if (access.canShowSanRescuerInfoMenu())
              _AgencyServiceItemData(
                title: 'امدادرسان',
                icon: Icons.grading_outlined,
                onTap: () {
                  context.pushNamed(RescuerListPage.name);
                },
              ),
            if (access.canShowSkillsCertificateButton())
              _AgencyServiceItemData(
                title: 'گواهینامه مهارت',
                icon: Icons.grading_outlined,
                onTap: () {
                  context.pushNamed(SkillsCertificatesPage.name);
                },
              ),

            if (access.canShowShift())
              _AgencyServiceItemData(
                title: 'شیفت',
                icon: Icons.grading_outlined,
                onTap: () {
                  context.pushNamed(ShiftListPage.name);
                },
              ),

            if (access.canShowIMEI())
              _AgencyServiceItemData(
                title: 'IMEI',
                icon: Icons.grading_outlined,
                onTap: () {
                  context.pushNamed(ImeiPage.name);
                },
              ),
          ];

          if (mainServices.isEmpty && agencyServices.isEmpty) {
            return const _EmptyServicesMessage(
              message: 'شما دسترسی لازم برای مشاهده خدمات را ندارید.',
            );
          }

          return _ServicesPageContent(
            mainServices: mainServices,
            agencyServices: agencyServices,
            onCartableTap: () => context.push(CartablePage.path),
          );
        },
      ),
    );
  }
}

class _ServicesPageContent extends StatelessWidget {
  const _ServicesPageContent({
    required this.mainServices,
    required this.agencyServices,
    required this.onCartableTap,
  });

  final List<_MainServiceItemData> mainServices;
  final List<_AgencyServiceItemData> agencyServices;
  final VoidCallback onCartableTap;

  static const double _maxContentWidth = 1100;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: _maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CartableTile(
                onTap: onCartableTap,
              ),
              Space.h24,
              if (mainServices.isNotEmpty) ...[
                const _ServicesSectionTitle(
                  title: 'خدمات اصلی',
                ),
                Space.h16,
                _MainServicesGrid(
                  items: mainServices,
                ),
              ],
              if (mainServices.isNotEmpty && agencyServices.isNotEmpty)
                Space.h24,
              if (agencyServices.isNotEmpty) ...[
                const _ServicesSectionTitle(
                  title: 'امور نمایندگی‌ها',
                ),
                Space.h16,
                _AgencyServicesGrid(
                  items: agencyServices,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CartableTile extends StatelessWidget {
  const _CartableTile({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    final borderRadius = BorderRadius.circular(AppSize.s12);

    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p10,
          ),
          child: Row(
            children: [
              Container(
                width: AppSize.s48,
                height: AppSize.s48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(AppSize.s16),
                ),
                child: Icon(
                  Icons.assignment_outlined,
                  size: AppSize.s24,
                  color: colorScheme.primary,
                ),
              ),
              Space.w12,
              Expanded(
                child: Text(
                  'کارتابل',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_left,
                size: AppSize.s20,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServicesSectionTitle extends StatelessWidget {
  const _ServicesSectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return Text(
      title,
      style: Theme
          .of(context)
          .textTheme
          .titleMedium
          ?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _MainServicesGrid extends StatelessWidget {
  const _MainServicesGrid({
    required this.items,
  });

  final List<_MainServiceItemData> items;

  static const double _maxItemWidth = 260;
  static const double _spacing = AppSize.s16;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 2;

        final availableWidth = constraints.maxWidth;

        final calculatedItemWidth =
            (availableWidth - _spacing) / crossAxisCount;

        final gridWidth = calculatedItemWidth > _maxItemWidth
            ? (_maxItemWidth * crossAxisCount) + _spacing
            : availableWidth;

        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: gridWidth,
            child: GridView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: _spacing,
                mainAxisSpacing: _spacing,
                mainAxisExtent: 145,
              ),
              itemBuilder: (context, index) {
                return _MainServiceItem(
                  item: items[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _MainServiceItem extends StatelessWidget {
  const _MainServiceItem({
    required this.item,
  });

  final _MainServiceItemData item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final borderRadius = BorderRadius.circular(AppSize.s12);

    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: borderRadius,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8,
                  vertical: AppPadding.p12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ServiceIconWidget(
                      backgroundColor: item.backgroundColor,
                      iconColor: colorScheme.onPrimary,
                      imagePath: item.imagePath,
                    ),
                    Space.h8,
                    BodyMediumText(
                      text: item.title,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: AppSize.s4,
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _AgencyServicesGrid extends StatelessWidget {
  const _AgencyServicesGrid({
    required this.items,
  });

  final List<_AgencyServiceItemData> items;

  static const double _maxItemWidth = 160;
  static const double _spacing = AppSize.s12;

  int _calculateColumnCount(double width) {
    if (width < 360) {
      return 2;
    }

    if (width < 600) {
      return 3;
    }

    if (width < 850) {
      return 4;
    }

    return 5;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        final requestedColumnCount =
        _calculateColumnCount(availableWidth);

        final crossAxisCount = requestedColumnCount > items.length
            ? items.length
            : requestedColumnCount;

        final totalSpacing =
            (crossAxisCount - 1) * _spacing;

        final calculatedItemWidth =
            (availableWidth - totalSpacing) / crossAxisCount;

        final gridWidth = calculatedItemWidth > _maxItemWidth
            ? (_maxItemWidth * crossAxisCount) + totalSpacing
            : availableWidth;

        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: Center(
            child: SizedBox(
              width: gridWidth,
              child: GridView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: _spacing,
                  mainAxisSpacing: _spacing,
                  mainAxisExtent: 105,
                ),
                itemBuilder: (context, index) {
                  return _AgencyServiceItem(
                    item: items[index],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AgencyServiceItem extends StatelessWidget {
  const _AgencyServiceItem({
    required this.item,
  });

  final _AgencyServiceItemData item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Material(
      color: colorScheme.onInverseSurface,
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(AppSize.s12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8,
            vertical: AppPadding.p8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: AppSize.s28,
                color: colorScheme.outline,
              ),
              Space.h8,
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.outline,
                  fontSize: AppSize.s14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyServicesMessage extends StatelessWidget {
  const _EmptyServicesMessage({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: BodyMediumText(
          text: message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _MainServiceItemData {
  const _MainServiceItemData({
    required this.title,
    required this.backgroundColor,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final Color backgroundColor;
  final String imagePath;
  final VoidCallback onTap;
}

class _AgencyServiceItemData {
  const _AgencyServiceItemData({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
}