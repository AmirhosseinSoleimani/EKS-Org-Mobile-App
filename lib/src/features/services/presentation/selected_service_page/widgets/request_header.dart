import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:flutter/material.dart';

class RequestHeader extends StatelessWidget {
  final BaseRequestEntity request;

  final Color serviceColor;
  final IconData serviceIcon;

  const RequestHeader({
    super.key,
    required this.request,
    required this.serviceColor,
    required this.serviceIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: serviceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            serviceIcon,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("${request.trackCode}"),
                  const Spacer(),
                  Text(request.requestDateJalali),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(request.requestStatusTitle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
