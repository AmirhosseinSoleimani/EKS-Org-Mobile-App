import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/cubit/indicator_report_cubit.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/view_models/parsed_segment.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bullet_point/bullet_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'report_viewer/row_card.dart';
import 'report_viewer/segment_chip.dart';

class IndicatorReportViewer extends StatelessWidget {
  final IndicatorReportEntity? indicatorReport;

  const IndicatorReportViewer({
    super.key,
    required this.indicatorReport,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IndicatorReportCubit>();
    final report = indicatorReport;

    if (report == null) return const SizedBox.shrink();

    return ValueListenableBuilder<ServiceType>(
      valueListenable: cubit.selectedServiceTypeNotifier,
      builder: (context, serviceType, _) {
        return Column(
          children: [
            _SimpleRow(
              title: 'تعداد تماس‌های ورودی',
              value: report.tootalCallLogCount,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد کل درخواست‌ها',
              value: report.totalRegisterServiceRequest.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد کل درخواست‌های اضطراری',
              value: report.totalUrgentServiceRequest.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های اعزام شده',
              value: report.totalServiceRequestHaveAssignDateCount.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های تکمیل شده',
              value: report.totalCompeletedServiceRequestCount.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های حمل آزاد',
              value: report.totalHamlAzadServiceRequestCount.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'درصد درخواست‌های حمل آزاد',
              value: '${report.totalHamlAzadServiceRequestPercent}%',
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های انجام شده و کنسل مجاز',
              value: report
                  .totalAllAllowdCancelationOrClosedServiceRequestsCount
                  .toString(),
              serviceType: serviceType,
            ),
            _ParsedMultiRow(
              title: 'تعداد درخواست‌های باز',
              rawValue: report.totalNotProceededServiceRequest,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های کنسل شده',
              value: report.allCancelationServiceRequestCount.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های کنسل شده قبل از اعزام',
              value: report.allBeforeAssignCancelationServiceRequestCount
                  .toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های کنسل شده بعد از اعزام (غیرمجاز)',
              value: report.totalAllNotAllowdCancelationServiceRequestCount
                  .toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های کنسل شده بعد از اعزام (مجاز)',
              value: report.totalAllAllowdCancelationServiceRequestCount
                  .toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد کل عدم همکاری‌ها',
              value: report.totalLackofCooperationCount.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد عدم همکاری‌های با وزن بیشتر از صفر',
              value: report.totalLackofCooperationWithGreaterThanZeroWeightCount
                  .toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'مجموع وزنی عدم همکاری‌ها',
              value: report.sumLackofCooperationsWithGreaterThanZireoWeight
                  .toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title:
                  'درصد عدم همکاری‌های با وزن بیشتر از صفر\nنسبت به درخواست‌های اعزام شده',
              value: '${report.lackofCooperationPercent}%',
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد کل امدادرسان‌های فعال',
              value: report.allActiveEmdadgars.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد کل امدادرسان‌های فعال درون شبکه',
              value: report.totalIntraNetworkActiveNavganCount.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های انجام شده و کنسل مجاز درون شبکه',
              value: report.totalIntraNetworkServiceRequestCount.toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'میانگین زمان ثبت درخواست نسبت به ثبت تماس',
              value: report.averageServiceRequestInsertDateToCallLogAnswerDate,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'میانگین زمان ثبت درخواست نسبت به ورود به صفحه ثبت',
              value: report.averageServiceRequestInsertDateToEntryPageDate,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'میانگین زمان تکمیل آدرس از طریق لینک',
              value: report.averageServiceRequestAddressLinkCompleteDate,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'میانگین زمان تکمیل آدرس نسبت به درخواست‌های اعزام شده',
              value: report
                  .averageServiceRequestAddressLinkCompleteDateHasAssignDate,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'میانگین زمان اعزام توسط اعزامگر نسبت به ثبت درخواست',
              value: report
                  .serviceRequestAverageInsertDateToAssingEmdadgarAssignDate,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'میانگین زمان اعزام واقعی نسبت به ثبت درخواست',
              value: report.averageServiceRequestAssignToInsertDate,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'میانگین زمان اعزام امدادرسان نسبت به رسیدن در محل',
              value: report.averageServiceRequestAssignEmdadgarArriveDateTime,
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های پیگیری شده با تبلت',
              value: report.serviceRequestEmdadgarFollowUpWithTabletCount
                  .toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'درصد پیگیری با تبلت',
              value:
                  '${report.serviceRequestEmdadgarFollowUpWithTabletPercent}%',
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'تعداد درخواست‌های ثبت فاکتور شده با تبلت',
              value: report.serviceRequestEmdadgarInvoicedWithTabletCount
                  .toString(),
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'درصد ثبت فاکتور با تبلت',
              value:
                  '${report.serviceRequestEmdadgarInvoicedWithTabletPercent}%',
              serviceType: serviceType,
            ),
            _SimpleRow(
              title: 'آمار دسته‌بندی درخواست‌های امدادی',
              value: report.serviceRequestCategoriesPercent,
              serviceType: serviceType,
            ),
            const SizedBox(height: AppSize.s16),
          ],
        );
      },
    );
  }
}



class _SimpleRow extends StatelessWidget {
  final String title;
  final String value;
  final ServiceType serviceType;

  const _SimpleRow({
    required this.title,
    required this.value,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RowCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BulletPoint(color: serviceType.serviceColor),
          Space.w8,
          Flexible(
            child: Text(
              title,
              style: textTheme.bodySmall,
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}

class _ParsedMultiRow extends StatelessWidget {
  final String title;
  final String rawValue;
  final ServiceType serviceType;

  const _ParsedMultiRow({
    required this.title,
    required this.rawValue,
    required this.serviceType,
  });

  List<ParsedSegment> _parse(String raw) {
    final parts =
        raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    return parts.map((part) {
      final colonIdx = part.lastIndexOf(':');
      if (colonIdx == -1) return ParsedSegment(label: part, value: '');

      final label = part.substring(0, colonIdx).trim();
      final valueRaw = part.substring(colonIdx + 1).trim();

      final parenMatch =
          RegExp(r'^(.*?)\s*\(([^)]+)\)\s*$').firstMatch(valueRaw);
      if (parenMatch != null) {
        return ParsedSegment(
          label: label,
          value: parenMatch.group(1)?.trim() ?? '',
          parenValue: parenMatch.group(2)?.trim(),
        );
      }

      return ParsedSegment(label: label, value: valueRaw);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final segments = _parse(rawValue);

    return RowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              BulletPoint(color: serviceType.serviceColor),
              Space.w8,
              Text(
                title,
                style: textTheme.bodySmall,
                textAlign: TextAlign.right,
              ),
              const SizedBox(width: AppSize.s8),
            ],
          ),
          const SizedBox(height: AppSize.s6),
          Wrap(
            spacing: AppSize.s8,
            runSpacing: AppSize.s4,
            alignment: WrapAlignment.spaceBetween,
            children: segments
                .map((seg) => SegmentChip(
                      segment: seg,
                      serviceType: serviceType,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}


