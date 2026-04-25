import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class ChassisRequestHeader extends StatelessWidget {
  final ChassisRequestHistoryEntity request;

  const ChassisRequestHeader({
    super.key,
    required this.request,
  });

  IconData _resolveServiceIcon(int? type) {
    switch (type) {
      case 1:
        return Icons.build;
      case 2:
        return Icons.home_repair_service;
      default:
        return Icons.miscellaneous_services;
    }
  }

  Color _resolveServiceColor(int? type) {
    switch (type) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = _resolveServiceIcon(request.type);
    final color = _resolveServiceColor(request.type);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyMediumText(text: request.typeTitle ?? '-'),
              const SizedBox(height: 8),
              Row(
                children: [
                  StatusLabel(
                    text: request.statusTitle ?? '-',
                    color: Colors.purple,
                  ),
                  Space.w8,
                  StatusLabel(
                    text: request.isGauranty == true
                        ? "گارانتی دارد"
                        : "گارانتی ندارد",
                    color: request.isGauranty == true
                        ? Colors.greenAccent
                        : Colors.red,
                  ),
                  Space.w8,
                  StatusLabel(
                    text:
                        request.isSubscription == true ? "مشترک" : "غیر مشترک",
                    color: request.isSubscription == true
                        ? Colors.greenAccent
                        : Colors.red,
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
