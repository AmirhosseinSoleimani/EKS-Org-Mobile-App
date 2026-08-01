import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/view_model/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/single_location_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class DeploymentLocationMapSelector extends StatelessWidget {
  const DeploymentLocationMapSelector({
    super.key,
    required this.onTap,
    this.latitude,
    this.longitude,
    this.hasSelectedLocation = false,
  });

  final VoidCallback onTap;
  final double? latitude;
  final double? longitude;
  final bool hasSelectedLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLatitude = latitude ?? AppConstants.defaultLatitude;
    final effectiveLongitude = longitude ?? AppConstants.defaultLongitude;

    return SizedBox(
      height: 270,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SingleLocationMapWidget(
          latitude: effectiveLatitude,
          longitude: effectiveLongitude,
          serviceType: ServiceType.reliefService,
          markerStyle: const MarkerStyle(iconPath: SvgManager.location),
          height: null,
          initialZoom: 15,
          onMapTap: (_) => onTap(),
        ),
      ),
    );
  }
}
