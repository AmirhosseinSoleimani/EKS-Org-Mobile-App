import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/cubit/request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/info_row.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/service_info_box.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/status_widget/status_widget.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/status_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_image_widget/asset_helper_car_face.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/image_widget/image_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RequestItem extends StatelessWidget {
  final RequestEntity item;
  final Color themeColor;

  const RequestItem({
    super.key,
    required this.item,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppSize.s8),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(color: colorScheme.onInverseSurface),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusRow(item: item),
            _gap(),
            _CarInfoRow(item: item, themeColor: themeColor),
            _gap(),
            _TypeInfoRow(item: item, colorScheme: colorScheme),
            _gap(),
            _ServiceInfoBoxRow(item: item, themeColor: themeColor),
            _gap(),
            if(item.actions?.any((a) => a.code == 'Details') ?? false)
            _DetailsButton(themeColor: themeColor, item: item),
          ],
        ),
      ),
    );
  }

  static SizedBox _gap() => Space.h20;
}



class _CarInfoRow extends StatelessWidget {
  final RequestEntity item;
  final Color themeColor;

  const _CarInfoRow({
    required this.item,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      leading: Container(
        height: AppSize.s54,
        decoration: BoxDecoration(
          color: themeColor.withAlpha(50),
          borderRadius: BorderRadius.circular(8),
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: ImageWidget.network(
            AssetHelperCarFace.getImagePathByCarModelId(item.carModelId),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      title: item.carName ?? '-',
      subtitle: item.defectTitle ?? '-',
      backgroundColor: themeColor.withAlpha(50),
    );
  }
}

class _TypeInfoRow extends StatelessWidget {
  final RequestEntity item;
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
      title: item.typeTitle ?? '-',
      subtitle: item.requestNo ?? '-',
      trailing: item.statusTitle != null
          ? StatusWidget(
              text: item.statusTitle!,
              color: colorScheme.onSecondaryFixed,
              hasBorder: true,
              hasBackground: false,
            )
          : null,
    );
  }
}

class _ServiceInfoBoxRow extends StatelessWidget {
  final RequestEntity item;
  final Color themeColor;

  const _ServiceInfoBoxRow({
    required this.item,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return ServiceInfoBox(
      serviceTime: item.serviceTime ?? '-',
      serviceDate: item.serviceDate ?? '-',
      address: item.location?.address ?? '-',
      themeColor: themeColor,
    );
  }
}

class _DetailsButton extends StatelessWidget {
  final RequestEntity item;
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
    final cubit = context.read<RequestListCubit>();
    cubit.setSelectedRequest(item);
    context.pushNamed<BottomSheetAction>(RequestDetailPage.name);
  }
}
