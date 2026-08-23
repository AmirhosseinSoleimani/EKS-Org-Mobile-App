import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/non_caching_network_tile_provider.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/search_address_page.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

export 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/non_caching_network_tile_provider.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.serviceType,
  });

  final ServiceType serviceType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();

    return RepaintBoundary(
      child: AppMap(
        mapController: cubit.mapController,
        serviceType: serviceType,
        initialCenter: cubit.location,
        initialZoom: 13,
        height: null,
        showFullScreenButton: false,
        onCurrentLocationTap: cubit.ensureAndCenterOnUser,
        onPositionChanged: (camera, _) => cubit.onMapMoved(camera),
        extraLayers: [CurrentLocationLayer()],
      ),
    );
  }
}

class MapActions extends StatelessWidget {
  const MapActions({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return FloatingActionButton.extended(
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      backgroundColor: colorScheme.onPrimary,
      onPressed: cubit.ensureAndCenterOnUser,
      icon: Icon(
        Icons.my_location_outlined,
        color: colorScheme.onTertiary,
      ),
      label: 'موقعیت من'.titleMedium(context, fontSize: AppSize.s16),
    );
  }
}

class MapSearchField extends StatelessWidget {
  const MapSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<MapCubit>();

    return TextFormFieldWidget(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p2,
      ),
      controller: TextEditingController(),
      readOnly: true,
      onTap: () {
        cubit.searchController.clear();
        cubit.addressToLocationResponseEntity =
            const AddressToLocationResponseEntity();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: const SearchAddressPage(),
            ),
          ),
        );
      },
      hintText: 'جستجوی آدرس ...',
      hintStyle: theme.textTheme.displayMedium?.copyWith(
        fontSize: AppSize.s14,
      ),
      suffixIcon: const Icon(Icons.search, size: AppSize.s24),
      backgroundColor: theme.colorScheme.surface,
      borderRadius: AppSize.s8,
    );
  }
}
