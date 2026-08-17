import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/cubit/indicator_report_cubit.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/view_models/parsed_segment.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bullet_point/bullet_point.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/stat_row_card/stat_row_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'row_card.dart';
import 'segment_chip.dart';

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
        final isReliefService = serviceType == ServiceType.reliefService;
        final categoryTitle = isReliefService
            ? 'آمار دسته‌بندی درخواست‌های امدادی'
            : 'آمار دسته‌بندی درخواست‌های خدمت در محل';

        return Column(
          children: [
            StatRowCard(
              title: 'تعداد تماس‌های ورودی',
              value: report.tootalCallLogCount,
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد کل درخواست‌ها',
              value: report.totalRegisterServiceRequest.toString(),
              serviceType: serviceType,
            ),
            if (isReliefService)
              StatRowCard(
                title: 'تعداد کل درخواست‌های اضطراری',
                value: report.totalUrgentServiceRequest.toString(),
                serviceType: serviceType,
              ),
            StatRowCard(
              title: 'تعداد درخواست‌های اعزام شده',
              value: report.totalServiceRequestHaveAssignDateCount.toString(),
              serviceType: serviceType,
            ),
            _ParsedMultiRow(
              title: 'تعداد درخواست‌های منجر به امداد',
              rawValue: isReliefService
                  ? 'تعداد کل: ${report.totalCompeletedServiceRequestCount}, '
                  'تعداد سرویس خارج از ناوگان: ${report.totalHamlAzadServiceRequestCount} '
                  '(${report.totalHamlAzadServiceRequestPercent})'
                  : 'تعداد کل: ${report.totalCompeletedServiceRequestCount}',
              serviceType: serviceType,
            ),
            _ParsedMultiRow(
              title: 'تعداد درخواست‌های باز',
              rawValue: report.totalNotProceededServiceRequest,
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد درخواست‌های کنسل شده',
              value: report.allCancelationServiceRequestCount.toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد درخواست‌های کنسل شده قبل از اعزام',
              value: report.allBeforeAssignCancelationServiceRequestCount
                  .toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد درخواست‌های کنسل شده بعد از اعزام (غیرمجاز)',
              value: report.totalAllNotAllowdCancelationServiceRequestCount
                  .toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد درخواست‌های کنسل شده بعد از اعزام (مجاز)',
              value: report.totalAllAllowdCancelationServiceRequestCount
                  .toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد درخواست‌های انجام شده و کنسل مجاز',
              value: report
                  .totalAllAllowdCancelationOrClosedServiceRequestsCount
                  .toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد کل عدم همکاری‌ها',
              value: report.totalLackofCooperationCount.toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد عدم همکاری‌های با وزن بیشتر از صفر',
              value: report.totalLackofCooperationWithGreaterThanZeroWeightCount
                  .toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'مجموع وزنی عدم همکاری‌ها',
              value: report.sumLackofCooperationsWithGreaterThanZireoWeight
                  .toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title:
              'درصد عدم همکاری‌های با وزن بیشتر از صفر نسبت به درخواست‌های اعزام شده',
              value: '${report.lackofCooperationPercent}%',
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد کل امدادرسان‌های فعال',
              value: report.allActiveEmdadgars.toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد کل امدادرسان‌های فعال درون شبکه',
              value: report.totalIntraNetworkActiveNavganCount.toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'تعداد درخواست‌های انجام شده و کنسل مجاز درون شبکه',
              value: report.totalIntraNetworkServiceRequestCount.toString(),
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'میانگین زمان ثبت درخواست نسبت به ثبت تماس',
              value: report.averageServiceRequestInsertDateToCallLogAnswerDate,
              serviceType: serviceType,
            ),
            StatRowCard(
              title:
              'میانگین زمان ثبت درخواست نسبت به ورود به صفحه ثبت درخواست',
              value: report.averageServiceRequestInsertDateToEntryPageDate,
              serviceType: serviceType,
            ),
            if (isReliefService) ...[
              StatRowCard(
                title: 'میانگین زمان تکمیل آدرس از طریق لینک',
                value: report.averageServiceRequestAddressLinkCompleteDate,
                serviceType: serviceType,
              ),
              StatRowCard(
                title: 'میانگین زمان تکمیل آدرس نسبت به درخواست‌های اعزام شده',
                value: report
                    .averageServiceRequestAddressLinkCompleteDateHasAssignDate,
                serviceType: serviceType,
              ),
            ],
            StatRowCard(
              title:
              'میانگین زمان اعزام امدادرسان توسط اعزامگر نسبت به ثبت درخواست',
              value: report
                  .serviceRequestAverageInsertDateToAssingEmdadgarAssignDate,
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'میانگین زمان اعزام واقعی امدادرسان نسبت به ثبت درخواست',
              value: report.averageServiceRequestAssignToInsertDate,
              serviceType: serviceType,
            ),
            StatRowCard(
              title: 'میانگین زمان اعزام امدادرسان نسبت به رسیدن در محل',
              value: report.averageServiceRequestAssignEmdadgarArriveDateTime,
              serviceType: serviceType,
            ),
            StatRowCard(
              title: categoryTitle,
              value: report.serviceRequestCategoriesPercent,
              serviceType: serviceType,
            ),
            _ParsedMultiRow(
              title:
              'تعداد و درصد درخواست‌های پیگیری شده با تبلت نسبت به درخواست‌های انجام شده و کنسل مجاز',
              rawValue:
              'تعداد: ${report.serviceRequestEmdadgarFollowUpWithTabletCount}, '
                  'درصد: ${report.serviceRequestEmdadgarFollowUpWithTabletPercent}',
              serviceType: serviceType,
            ),
            _ParsedMultiRow(
              title:
              'تعداد و درصد درخواست‌های ثبت فاکتور شده با تبلت نسبت به درخواست‌های انجام شده و کنسل مجاز',
              rawValue:
              'تعداد: ${report.serviceRequestEmdadgarInvoicedWithTabletCount}, '
                  'درصد: ${report.serviceRequestEmdadgarInvoicedWithTabletPercent}',
              serviceType: serviceType,
            ),
            const SizedBox(height: AppSize.s16),
          ],
        );
      },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BulletPoint(color: serviceType.serviceColor),
              Space.w8,
              Expanded(
                child: Text(
                  title,
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.right,
                ),
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
                .map(
                  (seg) => SegmentChip(
                segment: seg,
                serviceType: serviceType,
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}
