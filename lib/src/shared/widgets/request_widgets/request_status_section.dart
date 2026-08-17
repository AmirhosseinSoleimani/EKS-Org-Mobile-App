import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

import 'status_label.dart';

class RequestStatusSection extends StatelessWidget {
  final BaseRequestEntity? request;
  final bool showTitle;

  const RequestStatusSection({
    super.key,
    required this.request,
    this.showTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final trackCode = request?.trackCode.toString();
    final requestDateJalali = request?.requestDateJalali.toString();
    final requestTime = request?.requestTime.toString();
    final requestStatusTitle = request?.requestStatusTitle;
    final isGuaranty =
        request?.isGuaranty == true || request?.garantyIsGaranty == true;
    final isSubscription = request?.isSubscription ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (showTitle)...[
          const Align(
            alignment: Alignment.centerRight,
            child: BodyMediumText(text: 'اطلاعات درخواست'),
          ),
          const SizedBox(height: 6),
        ],

        BodySmallText(
          text: '$trackCode | $requestDateJalali - $requestTime',
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            StatusLabel(
              text: requestStatusTitle ?? '-',
              color: Colors.purple,
            ),
            StatusLabel(
              text: isSubscription ? 'مشترک' : 'غیر مشترک',
              color: isSubscription ? Colors.greenAccent : Colors.red,
            ),
            StatusLabel(
              text: isGuaranty ? 'گارانتی دارد' : 'گارانتی ندارد',
              color: isGuaranty ? Colors.greenAccent : Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
