import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/section_container.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/info_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_image_widget/asset_helper_car_face.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/image_widget/image_widget.dart';
import 'package:flutter/material.dart';

class RequestDetailCarInfoWidget extends StatelessWidget {
  final RequestEntity item;

  const RequestDetailCarInfoWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final carTag = item.licensePlate?.split(' ') ?? [];
    return SectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: InfoRow(
        leading: Container(
          height: AppSize.s54,
          decoration: BoxDecoration(
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
        subtitle: item.chassisNo ?? '-',
        backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(24),
        trailing: const SizedBox(
          width: AppSize.s120,
          height: AppSize.s34,
          child: SizedBox(),
        ),
      ),
    );
  }
}
