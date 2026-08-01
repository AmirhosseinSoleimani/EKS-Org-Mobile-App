import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/emdadgar_marker_style_resolver.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/single_location_map_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/widgets/request_widgets/key_value_row.dart';

class RequestLocationDetailSection extends StatelessWidget {
  final String? province;
  final String? city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final ServiceType serviceType;

  const RequestLocationDetailSection({
    super.key,
    this.province,
    this.city,
    this.address,
    this.latitude,
    this.longitude,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KeyValueRow(
          label: "استان",
          value: province ?? "-",
        ),
        const SizedBox(height: 8),
        KeyValueRow(
          label: "شهر",
          value: city ?? "-",
        ),
        const SizedBox(height: 8),
        KeyValueRow(
          label: "آدرس",
          value: address ?? "-",
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 250,
          child: SingleLocationMapWidget(
              latitude: latitude ?? AppConstants.defaultLatitude,
              longitude: longitude ?? AppConstants.defaultLongitude,
              serviceType: serviceType,
              height: null,
              markerStyle: const EmdadgarMarkerStyleResolver().resolveCustomer(),
            ),
        ),
      ],
    );
  }
}
