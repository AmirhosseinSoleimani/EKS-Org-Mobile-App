import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

import 'status_label.dart';

class RequestStatusSection extends StatelessWidget {
  final BaseRequestEntity? request;

  const RequestStatusSection({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final trackCode = request?.trackCode.toString();

    final requestDateJalali = request?.requestDateJalali.toString();
    final requestTime = request?.requestTime.toString();
    final requestStatusTitle = request?.requestStatusTitle;
    final isGuaranty = request?.isGuaranty ?? false;
    final isSubscription = request?.isSubscription ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodySmallText(
          text: "$trackCode | $requestDateJalali - $requestTime",
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            StatusLabel(
              text: requestStatusTitle ?? '-',
              color: Colors.purple,
            ),
            Space.w8,
            StatusLabel(
              text: isGuaranty ? "گارانتی دارد" : "گارانتی ندارد",
              color: isGuaranty ? Colors.greenAccent : Colors.red,
            ),
            Space.w8,
            StatusLabel(
              text: isSubscription ? "مشترک" : "غیر مشترک",
              color: isSubscription ? Colors.greenAccent : Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
