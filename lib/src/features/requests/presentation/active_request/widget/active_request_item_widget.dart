import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/active_request/cubit/active_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/info_box_item.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/info_row.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_image_widget/asset_helper_car_face.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/image_widget/image_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/status_widget/status_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActiveRequestItemWidget extends StatelessWidget {
  final RequestEntity? item;
  final Color themeColor;

  const ActiveRequestItemWidget({
    super.key,
    required this.item,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.s8),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(
            color: colorScheme.onError,
            width: AppSize.s2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StatusWidget(
                  text: (item?.hasSubscription ?? false) ? 'مشترک' : 'غیرمشترک',
                  color: (item?.hasSubscription ?? false)
                      ? colorScheme.primary
                      : colorScheme.error,
                ),
                StatusWidget(
                  text: (item?.isGuaranty ?? false)
                      ? 'دارای گارانتی'
                      : 'فاقد گارانتی',
                  color: (item?.isGuaranty ?? false)
                      ? colorScheme.primary
                      : colorScheme.error,
                ),
              ],
            ),
            Space.h16,
            _CarInfoRow(item: item, themeColor: themeColor),
            Space.h16,
            _TypeInfoRow(item: item, colorScheme: colorScheme),
            Space.h16,
            _ServiceInfoBoxRow(item: item, themeColor: themeColor),
            Space.h16,
            _DetailsButton(themeColor: themeColor, item: item),
          ],
        ),
      ),
    );
  }
}



class _CarInfoRow extends StatelessWidget {
  final RequestEntity? item;
  final Color themeColor;

  const _CarInfoRow({
    required this.item,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      leading: SizedBox(
        height: AppSize.s54,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: ImageWidget.network(
              AssetHelperCarFace.getImagePathByCarModelId(item?.carModelId),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
      title: item?.carName ?? '-',
      subtitle: item?.defectTitle ?? '-',
      backgroundColor: themeColor.withOpacity(0.1),
    );
  }
}

class _TypeInfoRow extends StatelessWidget {
  final RequestEntity? item;
  final ColorScheme colorScheme;

  const _TypeInfoRow({
    required this.item,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      leading: const SvgWidget(
        src: SvgAsset(SvgManager.emergencyAssistanceRoundedSquare),
        width: AppSize.s54,
        height: AppSize.s54,
      ),
      title: (item?.type == RequestType.homeService.value)
          ? 'خدمات در محل'
          : 'خدمات امدادی',
      subtitle: item?.id.toString() ?? '-',
      trailing: item?.statusTitle != null
          ? StatusWidget(
              text: item?.statusTitle ?? '-',
              color: colorScheme.onSecondaryFixed,
              hasBorder: true,
        hasBackground: false,
      )
          : null,
    );
  }
}

class _ServiceInfoBoxRow extends StatelessWidget {
  final RequestEntity? item;
  final Color themeColor;

  const _ServiceInfoBoxRow({
    required this.item,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return ServiceInfoBox(
      serviceTime: item?.serviceTime ?? '-',
      serviceDate: item?.serviceDate ?? '-',
      address: item?.location?.address ?? '-',
      themeColor: themeColor,
    );
  }
}

class _DetailsButton extends StatelessWidget {
  final RequestEntity? item;
  final Color themeColor;

  const _DetailsButton({required this.themeColor, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkwellButtonWidget(
      splashColor: themeColor.withAlpha(30),
      title: 'مشاهده جزئیات',
      textStyle: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: themeColor, fontSize: AppSize.s14),
      suffixIcon: Container(
        padding: const EdgeInsets.all(AppPadding.p4),
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        decoration: BoxDecoration(
          border: Border.all(color: themeColor, width: 1.5),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: AppSize.s10,
          color: themeColor,
        ),
      ),
      backgroundColor: Colors.transparent,
      borderColor: themeColor,
      onTap: () => _goToRequestDetailPage(context),
    );
  }

  _goToRequestDetailPage(BuildContext context) async {
    if (item != null) {
      final cubit = context.read<ActiveRequestCubit>();
      cubit.setSelectedRequest(item!);
      context.pushNamed<BottomSheetAction>(RequestDetailPage.name);
    }
  }
}

class ServiceInfoBox extends StatelessWidget {
  final String serviceTime;
  final String serviceDate;
  final String address;
  final Color themeColor;

  const ServiceInfoBox({
    super.key,
    required this.serviceTime,
    required this.serviceDate,
    required this.address,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppPadding.p8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:AppPadding.p20, horizontal:AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoBoxItem(
                  icon: Icons.access_time_outlined,
                  text: serviceTime.to12HourFormat(),
                  iconBackgroundColor: themeColor.withOpacity(0.8),
                ),
                const SizedBox(width: AppPadding.p16),
                InfoBoxItem(
                  icon: Icons.calendar_today_outlined,
                  text: serviceDate,
                  iconBackgroundColor: themeColor.withOpacity(0.8),
                ),
              ],
            ),
            Space.h24,
            InfoBoxItem(
              icon: Icons.location_on_outlined,
              text: address,
              iconBackgroundColor: themeColor.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
