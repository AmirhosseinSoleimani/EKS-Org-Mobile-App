import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
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
    final trackCode = request?.trackCode?.toString() ?? '-';
    final requestDateJalali = request?.requestDateJalali ?? '-';
    final requestTime = request?.requestTime ?? '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          const BodyMediumText(text: 'اطلاعات درخواست'),
          const SizedBox(height: 8),
        ],
        BodySmallText(
          text: '$trackCode | $requestDateJalali - $requestTime',
        ),
        const SizedBox(height: 6),
        _AdaptiveStatusLabels(labels: _buildLabels()),
      ],
    );
  }

  List<_RequestStatusLabelData> _buildLabels() {
    if (request?.serviceType == ServiceType.homeService) {
      return _buildHomeServiceLabels();
    }

    return _buildReliefLabels();
  }

  List<_RequestStatusLabelData> _buildReliefLabels() {
    final labels = <_RequestStatusLabelData>[];
    final relief = request is ReliefRequestEntity
        ? request as ReliefRequestEntity
        : null;

    if (relief?.isUrgentRequest == true) {
      labels.add(
        _RequestStatusLabelData(
          text: 'اضطراری',
          color: relief?.isUrgentRequestCompleted == true
              ? Colors.green
              : Colors.deepOrange,
        ),
      );
    }

    _addRequestStatus(labels);

    if (request?.isNewCar == true) {
      labels.add(
        const _RequestStatusLabelData(
          text: 'خودروی نو',
          color: Colors.black87,
        ),
      );
    }

    _addSubscription(labels);
    _addSpecialPlan(labels);
    _addGuaranty(labels);
    _addVip(labels);
    _addTrafficPlan(labels);

    // SanaPlus does not show this badge for a canceled relief request.
    if (request?.requestStatus != 2) {
      _addOutOfFleetPermit(labels);
    }

    return labels;
  }

  List<_RequestStatusLabelData> _buildHomeServiceLabels() {
    final labels = <_RequestStatusLabelData>[];

    if (request?.isNewCar == true) {
      labels.add(
        const _RequestStatusLabelData(
          text: 'خودروی نو',
          color: Colors.black87,
        ),
      );
    }

    _addVip(labels);
    _addTrafficPlan(labels);
    _addOutOfFleetPermit(labels);
    _addRequestStatus(labels);
    _addSubscription(labels);
    _addGuaranty(labels);

    return labels;
  }

  void _addRequestStatus(List<_RequestStatusLabelData> labels) {
    labels.add(
      _RequestStatusLabelData(
        text: request?.requestStatusTitle ?? '-',
        color: Colors.purple,
      ),
    );
  }

  void _addSubscription(List<_RequestStatusLabelData> labels) {
    final isSubscription = request?.isSubscription == true;
    labels.add(
      _RequestStatusLabelData(
        text: isSubscription ? 'مشترک' : 'غیر مشترک',
        color: isSubscription ? Colors.green : Colors.red,
      ),
    );
  }

  void _addSpecialPlan(List<_RequestStatusLabelData> labels) {
    if (request?.hasSpecialPlan != true) return;

    final specialPlanTitle = request?.specialPlanTitle?.trim();
    if (specialPlanTitle != null && specialPlanTitle.isNotEmpty) {
      labels.add(
        _RequestStatusLabelData(
          text: specialPlanTitle,
          color: Colors.blueGrey.shade800,
        ),
      );
    }

    final specialPlanZoneTitle = request?.specialPlanZoneTitle?.trim();
    if (specialPlanZoneTitle != null && specialPlanZoneTitle.isNotEmpty) {
      labels.add(
        _RequestStatusLabelData(
          text: specialPlanZoneTitle,
          color: Colors.lightBlue.shade700,
        ),
      );
    }
  }

  void _addGuaranty(List<_RequestStatusLabelData> labels) {
    final isGuaranty =
        request?.isGuaranty == true || request?.garantyIsGaranty == true;
    labels.add(
      _RequestStatusLabelData(
        text: isGuaranty ? 'گارانتی دارد' : 'گارانتی ندارد',
        color: isGuaranty ? Colors.amber.shade800 : Colors.red,
      ),
    );
  }

  void _addVip(List<_RequestStatusLabelData> labels) {
    if (request?.vip != true) return;

    final title = request?.vipConditionTitle?.trim();
    labels.add(
      _RequestStatusLabelData(
        text: title == null || title.isEmpty
            ? 'شرایط خاص'
            : 'شرایط خاص: $title',
        color: Colors.cyan.shade700,
      ),
    );
  }

  void _addTrafficPlan(List<_RequestStatusLabelData> labels) {
    if (request?.hasTrafficOrPollutionPlan != true) return;

    labels.add(
      const _RequestStatusLabelData(
        text: 'طرح ترافیکی / آلودگی هوا',
        color: Colors.pink,
      ),
    );
  }

  void _addOutOfFleetPermit(List<_RequestStatusLabelData> labels) {
    if (request?.hamlAzad != true || request?.reasonHamlAzadId == null) return;

    labels.add(
      const _RequestStatusLabelData(
        text: 'مجوز امداد خارج از ناوگان',
        color: Colors.indigo,
      ),
    );
  }
}

class _AdaptiveStatusLabels extends StatelessWidget {
  const _AdaptiveStatusLabels({required this.labels});

  final List<_RequestStatusLabelData> labels;

  static const double _spacing = 8;
  static const double _minimumReadableScale = 0.82;

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final requiredWidth = _estimateRequiredWidth(context);
        final availableWidth = constraints.maxWidth;
        final scale = availableWidth > 0 && requiredWidth > 0
            ? availableWidth / requiredWidth
            : 1.0;

        final labelsRow = _buildRow();

        if (requiredWidth <= availableWidth) {
          return labelsRow;
        }

        if (scale >= _minimumReadableScale) {
          return SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: labelsRow,
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: labelsRow,
        );
      },
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < labels.length; index++) ...[
          if (index > 0) const SizedBox(width: _spacing),
          StatusLabel(
            text: labels[index].text,
            color: labels[index].color,
          ),
        ],
      ],
    );
  }

  double _estimateRequiredWidth(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
    final textDirection = Directionality.of(context);

    var width = _spacing * (labels.length - 1);
    for (final label in labels) {
      final painter = TextPainter(
        text: TextSpan(text: label.text, style: textStyle),
        textDirection: textDirection,
        maxLines: 1,
      )..layout();

      // StatusLabel default horizontal padding is 8 on each side.
      width += painter.width + 16;
    }

    return width;
  }
}

class _RequestStatusLabelData {
  const _RequestStatusLabelData({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;
}
