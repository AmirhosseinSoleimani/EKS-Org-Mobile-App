import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

class RequestHeader extends StatelessWidget {
  final BaseRequestEntity request;
  const RequestHeader({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: request.serviceType?.serviceColor.withAlpha(40),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            width: 48,
            height: 48,
            request.serviceType == ServiceType.reliefService
                ? ImageManager.emdadServece
                : ImageManager.locationService,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ListItemTitleText(text: "${request.trackCode}", maxLines: 1),
                  const Spacer(),
                  ListItemMetaText(text: request.requestDateJalali ?? '---'),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: BodySmallText(text: request.requestStatusTitle ?? ''),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
