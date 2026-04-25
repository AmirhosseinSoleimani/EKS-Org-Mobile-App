import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

import 'status_label.dart';

class RequestStatusSection extends StatelessWidget {
  final String trackCode;
  final String requestDateJalali;
  final String requestTime;
  final String? requestStatusTitle;
  final bool isGuaranty;
  final bool isSubscription;

  const RequestStatusSection({
    super.key,
    required this.trackCode,
    required this.requestDateJalali,
    required this.requestTime,
    required this.requestStatusTitle,
    required this.isGuaranty,
    required this.isSubscription,
  });

  @override
  Widget build(BuildContext context) {
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
