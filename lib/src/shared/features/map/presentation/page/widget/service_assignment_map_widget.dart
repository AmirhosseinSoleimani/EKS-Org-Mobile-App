import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/EmdadgarMapMarkerConfig.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/emdadgar_marker_style_resolver.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_pin_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/multi_location_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class ServiceAssignmentMapWidget extends StatelessWidget {
  const ServiceAssignmentMapWidget({
    super.key,
    required this.emdadgars,
    required this.customerLatitude,
    required this.customerLongitude,
    required this.serviceType,
    this.initialZoom = 12,
    this.height = 520,
    this.onEmdadgarTap,
    this.onCurrentLocationTap,
    this.isFullScreen = false,
  });

  final List<EmdadgarEntity> emdadgars;
  final double customerLatitude;
  final double customerLongitude;
  final ServiceType serviceType;
  final double initialZoom;
  final double? height;
  final void Function(EmdadgarEntity emdadgar)? onEmdadgarTap;
  final VoidCallback? onCurrentLocationTap;
  final bool isFullScreen;


  LatLng get _customerPoint => LatLng(customerLatitude, customerLongitude);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignAndCancelEmdadgarCubit,
        AssignAndCancelEmdadgarState>(
      builder: (context, state) {
        final loadingEmdadgarId = state.maybeWhen(
          checkDepotLoading: (emdadgarId) => emdadgarId,
          orElse: () => null,
        );

        return AbsorbPointer(
          absorbing: loadingEmdadgarId != null,
          child: MultiLocationMapWidget(
            markers: _buildMarkers(),
            initialCenter: _customerPoint,
            serviceType: serviceType,
            initialZoom: initialZoom,
            height: height,
            isFullScreen: isFullScreen,
            onCurrentLocationTap: onCurrentLocationTap,
            onFullScreenTap: isFullScreen
                ? null
                : () => _openFullScreenMap(context),
            bottomOverlay: const PositionedDirectional(
              start: AppPadding.p16,
              end: AppPadding.p16,
              bottom: AppPadding.p16,
              child: _AssignmentMapLegend(),
            ),
          ),
        );
      },
    );
  }

  List<AppMapMarker> _buildMarkers() {
    const resolver = EmdadgarMarkerStyleResolver();
    final customerStyle = resolver.resolveCustomer();

    return [
      AppMapMarker(
        point: _customerPoint,
        width: AppSize.s42,
        height: AppSize.s42,
        child: MapPinMarker(
          iconPath: customerStyle.iconPath,
          color: customerStyle.color,
        ),
      ),
      ...emdadgars
          .where(
            (item) =>
                item.lastLocationLatitude != null &&
                item.lastLocationLongitude != null,
          )
          .map((emdadgar) {
        final markerStyle = resolver.resolve(emdadgar);

        return AppMapMarker(
          point: LatLng(
            emdadgar.lastLocationLatitude!,
            emdadgar.lastLocationLongitude!,
          ),
          width: AppSize.s48,
          height: AppSize.s48,
          onTap: () => onEmdadgarTap?.call(emdadgar),
          child: MapPinMarker(
            iconPath: markerStyle.iconPath,
            color: markerStyle.color,
          ),
        );
      }),
    ];
  }

  void _openFullScreenMap(BuildContext context) {
    final cubit = context.read<AssignAndCancelEmdadgarCubit>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: ServiceAssignmentMapWidget(
              emdadgars: emdadgars,
              customerLatitude: customerLatitude,
              customerLongitude: customerLongitude,
              serviceType: serviceType,
              initialZoom: initialZoom,
              height: MediaQuery.sizeOf(context).height,
              onEmdadgarTap: onEmdadgarTap,
              onCurrentLocationTap: onCurrentLocationTap,
              isFullScreen: true,
            ),
          ),
        );
      },
    );
  }
}

class _AssignmentMapLegend extends StatelessWidget {
  const _AssignmentMapLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p14,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(
              color: MapMarkerConfig.customerColor,
              title: 'مشتری',
            ),
            _DividerText(),
            _LegendItem(
              color: MapMarkerConfig.readyColor,
              title: 'آماده خدمت',
            ),
            _DividerText(),
            _LegendItem(
              color: MapMarkerConfig.allocatedColor,
              title: 'در حال خدمت',
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.title});

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: color, size: AppSize.s20),
        const SizedBox(width: AppSize.s4),
        BodyMediumText(
          text: title,
          fontSize: AppSize.s12,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _DividerText extends StatelessWidget {
  const _DividerText();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: BodyMediumText(
        text: '|',
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
