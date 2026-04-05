import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AddressBoxWidget extends StatelessWidget {
  final RequestEntity selectedRequest;

  const AddressBoxWidget({super.key, required this.selectedRequest});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SectionContainer(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedRequest.location?.latitude != null &&
              selectedRequest.location?.longitude != null)
            SizedBox(
              height: AppSize.s150,
            /*  child: NonInteractiveMapPage(
                type: ServiceType.homeService,
                longitude: selectedRequest.location!.longitude!,
                latitude: selectedRequest.location!.latitude!,
              ),*/
            )
          else
            Container(
              color: Colors.grey,
              width: double.infinity,
              height: AppSize.s150,
            ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'اعزام به آدرس : ',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: AppSize.s14,
                      color: colorScheme.shadow
                    ),
                  ),
                  TextSpan(
                    text: selectedRequest.location?.address ?? '-',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: AppSize.s14,
                        color: colorScheme.onSecondaryFixed
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}