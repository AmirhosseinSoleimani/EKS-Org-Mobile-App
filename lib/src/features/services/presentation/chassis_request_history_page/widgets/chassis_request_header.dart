import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class ChassisRequestHeader extends StatelessWidget {
  final ChassisRequestHistoryEntity request;

  const ChassisRequestHeader({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final serviceType = request.serviceType;
    final isReliefService =
        request.type == ServiceType.reliefService.value;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 54,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: serviceType.serviceColor.withAlpha(40),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            isReliefService
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
              BodyMediumText(text: request.typeTitle ?? '-'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  StatusLabel(
                    text: request.statusTitle ?? '-',
                    color: Colors.purple,
                  ),
                  StatusLabel(
                    text: request.isGauranty == true
                        ? 'گارانتی دارد'
                        : 'گارانتی ندارد',
                    color: request.isGauranty == true
                        ? Colors.greenAccent
                        : Colors.red,
                  ),
                  if (request.shouldShowSubscriptionStatus)
                    StatusLabel(
                      text: request.isSubscription == true
                          ? 'مشترک'
                          : 'غیر مشترک',
                      color: request.isSubscription == true
                          ? Colors.greenAccent
                          : Colors.red,
                    ),
                  if (request.shouldShowVipStatus)
                    StatusLabel(
                      text: request.vipConditionTitle?.trim().isNotEmpty == true
                          ? 'شرایط خاص: ${request.vipConditionTitle!.trim()}'
                          : 'شرایط خاص',
                      color: Colors.cyan,
                    ),
                  if (request.shouldShowOutOfFleetPermit)
                    const StatusLabel(
                      text: 'مجوز امداد خارج از ناوگان',
                      color: Colors.indigo,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
