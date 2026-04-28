import 'package:eks_sana_plus_org/src/features/services/presentation/online_map_page/cubit/online_map_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/expand_toggle_button.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/online_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineMapSection extends StatelessWidget {
  const OnlineMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnlineMapCubit, OnlineMapState>(
      buildWhen: (_, __) => true,
      builder: (context, state) {
        final cubit = context.read<OnlineMapCubit>();

        final routeData = cubit.routeDataEntity;
        final request = cubit.selectedRequest;
        final emdadgar = cubit.emdadgarInfo;
        final isExpanded = cubit.isDetailsExpanded;

        if (routeData == null || request == null || emdadgar == null) {
          return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const EmptyListWidget()]);
        }

        final route =
            routeData.routes.isNotEmpty ? routeData.routes.first : null;
        final durationText = route?.duration.text ?? "-";
        final distanceText = route?.distance.text ?? "-";

        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 1.2,
                child: OnlineMapWidget(
                  mapData: routeData,
                  emdadgarLat: emdadgar.lastLocationLatitude ?? 0,
                  emdadgarLng: emdadgar.lastLocationLongitude ?? 0,
                  destLat: request.latitude ?? 0,
                  destLng: request.longitude ?? 0,
                ),
              ),
            ),
            Space.h16,
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 3,
              mainAxisSpacing: AppSize.s8,
              crossAxisSpacing: AppSize.s8,
              children: [
                KeyValueRow(label: "زمان مسیر", value: durationText),
                KeyValueRow(label: "فاصله مسیر", value: distanceText),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: isExpanded ? 160 : 0,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Space.h8,
                    KeyValueRow(
                      label: "استان",
                      value: request.provinceName ?? "-",
                    ),
                    Space.h8,
                    KeyValueRow(
                      label: "شهر",
                      value: request.cityName ?? "-",
                    ),
                    Space.h8,
                    KeyValueRow(
                      label: "آدرس",
                      value: request.aidAddress ?? "-",
                    ),
                  ],
                ),
              ),
            ),
            ExpandToggleButton(
              label: isExpanded ? "جزئیات کمتر" : "جزئیات بیشتر",
              icon:  isExpanded ? Icons.expand_less : Icons.expand_more,
              onTap: cubit.toggleMapDetails,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        );
      },
    );
  }
}
