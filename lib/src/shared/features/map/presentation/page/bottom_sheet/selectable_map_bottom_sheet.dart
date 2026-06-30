import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/selectable_map_page.dart';
import 'package:flutter/material.dart';

class SelectableMapBottomSheet {
  static Future<AddressInfoEntity?> show({
    required BuildContext context,
    required ServiceType serviceType,
    AddressInfoEntity? initialLocation,
  }) async {
    return await showModalBottomSheet<AddressInfoEntity>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SelectableMapPage(initialLocation: initialLocation,
              serviceType: serviceType),
        );
      },
    );
  }
}
