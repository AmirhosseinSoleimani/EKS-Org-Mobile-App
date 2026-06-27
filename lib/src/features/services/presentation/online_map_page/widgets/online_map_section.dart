import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/online_map_page/cubit/online_map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/expand_toggle_button.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/online_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/static_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/emdadgar_marker_style_resolver.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/emdadgar_marker_style_resolver.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/route_map_widget.dart';
class OnlineMapSection extends StatelessWidget {
  const OnlineMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnlineMapCubit, OnlineMapState>(
      buildWhen: (_, _) => true,
      builder: (context, state) {
        final cubit = context.read<OnlineMapCubit>();

        final routeData = cubit.routeDataEntity;
        final request = cubit.selectedRequest;
        final emdadgar = cubit.emdadgarInfo;
        final isExpanded = cubit.isDetailsExpanded;

        const markerStyleResolver = EmdadgarMarkerStyleResolver();

        final mapHeight = MediaQuery.of(context).size.width * 1.2;

        final canShowRouteMap = routeData != null && emdadgar != null;

        return Container(
          padding: const EdgeInsets.all(AppSize.s16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 1.2,
                    child: canShowRouteMap
                        ? RouteMapWidget(
                      routeData: routeData,
                      height: mapHeight,
                      showInfoBox: false,
                      startMarkerStyle: markerStyleResolver.resolveInfo(emdadgar),
                      destinationMarkerStyle: markerStyleResolver.resolveCustomer(),
                    ) : StaticMapWidget(
                      serviceType: request?.serviceType ?? ServiceType.reliefService,
                      latitude: request?.latitude ?? 0,
                      longitude: request?.longitude ?? 0,
                    ),
                ),
              ),
              Space.h16,
              Column(
                children: [
                  KeyValueRow(
                    label: "زمان تقریبی (اعزام)",
                    value: (request is ReliefRequestEntity) ? request
                        .emdadgarAssignDurationTitle ?? "-" : "-",
                  ),
                  Space.h8,
                  KeyValueRow(
                    label: "زمان تقریبی (اکنون)",
                    value: routeData?.routes.first.duration.text ?? "-",
                  ),
                  Space.h8,
                  KeyValueRow(
                    label: "فاصله تقریبی (اعزام)",
                    value: (request is ReliefRequestEntity) ? request
                        .emdadgarAssignDistanceTitle ?? "-" : '-',
                  ),
                  Space.h8,
                  KeyValueRow(
                    label: "فاصله تقریبی (اکنون)",
                    value: routeData?.routes.first.distance.text ?? "-",
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                height: isExpanded ? 80 : 0,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Space.h8,
                      KeyValueRow(
                        label: "استان",
                        value: request?.provinceName ?? "-",
                      ),
                      Space.h8,
                      KeyValueRow(
                        label: "شهر",
                        value: request?.cityName ?? "-",
                      ),
                      Space.h8,
                      KeyValueRow(
                        label: "آدرس",
                        value: request?.aidAddress ?? "-",
                      ),
                    ],
                  ),
                ),
              ),
              ExpandToggleButton(
                label: isExpanded ? "جزئیات کمتر" : "جزئیات بیشتر",
                icon: isExpanded ? Icons.expand_less : Icons.expand_more,
                onTap: cubit.toggleMapDetails,
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
            ],
          ),
        );
      },
    );
  }
}
