import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RequestDetailSection extends StatelessWidget {
  const RequestDetailSection({
    super.key,
    required this.selectedRequest,
    this.showCustomerInfo = false,
  });

  final BaseRequestEntity? selectedRequest;
  final bool showCustomerInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseFontSize = theme.textTheme.bodySmall?.fontSize ?? AppSize.s12;
    final defaultFontSize = baseFontSize + AppSize.s2;
    final resolvedLabelFontSize =  defaultFontSize;
    final resolvedValueFontSize = defaultFontSize;
    return Column(
      children: [
        KeyValueRow(
          label: 'شماره درخواست',
          value: selectedRequest?.trackCode?.toString() ?? '-',
        ),
        KeyValueRow(
          label: 'زمان ثبت',
          value: _requestDateTime,
        ),
        if (homeServiceRequest?.bookedDateTimeJalali?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'زمان رزرو شده',
            value: homeServiceRequest!.bookedDateTimeJalali!,
          ),
        if (selectedRequest?.insertUserName?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'ثبت کننده',
            value: selectedRequest!.insertUserName!,
          ),
        if (selectedRequest?.updateUserName?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'ویرایش کننده',
            value: selectedRequest!.updateUserName!,
          ),
        if (selectedRequest is ReliefRequestEntity) ...[
          KeyValueRow(
            label: 'ایراد خودرو',
            value: _displayText(reliefRequest?.defectTitle),
          ),
          KeyValueRow(
            label: 'سرویس خودرو',
            value: _displayText(reliefRequest?.emdadServiceTitle),
          ),
          if (reliefRequest?.emdadServiceCategoryId == 21) ...[
            KeyValueRow(
              label: 'وضعیت خودرو',
              value: reliefRequest?.hamlReasonTitle ?? '-',
            ),
            KeyValueRow(
              label: 'وضعیت چرخ‌ها',
              value: reliefRequest?.wheelQuestionTitle ?? '-',
            ),
          ],
        ] else if (selectedRequest is HomeServiceRequestEntity)
          KeyValueRow(
            label: 'سرویس درخواستی',
            value: _firstNonBlank([
              homeServiceRequest?.emdadProductTitle,
              homeServiceRequest?.emdadServiceCategoryTitle,
            ]),
          ),
        if (selectedRequest?.hamlAzad == true &&
            selectedRequest?.reasonHamlAzadId != null) ...[
          if (selectedRequest?.reasonHamlAzadTitle?.trim().isNotEmpty == true)
            KeyValueRow(
              label: 'دلیل امداد خارج از ناوگان',
              value: selectedRequest!.reasonHamlAzadTitle!,
            ),
          if (selectedRequest?.reasonHamlAzadDesc?.trim().isNotEmpty == true)
            KeyValueRow(
              label: 'توضیحات امداد خارج از ناوگان',
              value: selectedRequest!.reasonHamlAzadDesc!,
            ),
        ],
        if (selectedRequest?.cancelReasonTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'علت لغو',
            value: selectedRequest!.cancelReasonTitle!,
          ),
        if (selectedRequest?.cancelReasonDetailTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'جزئیات لغو',
            value: selectedRequest!.cancelReasonDetailTitle!,
          ),
        if (selectedRequest?.cancelReasonDescription?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'توضیحات لغو',
            value: selectedRequest!.cancelReasonDescription!,
          ),
        if (selectedRequest?.cancelAssignDescription?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'توضیحات لغو درخواست',
            value: selectedRequest!.cancelAssignDescription!,
          ),
        if (selectedRequest?.garantyDescription?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'توضیحات گارانتی',
            value: selectedRequest!.garantyDescription!,
          ),
        if (selectedRequest?.nightOrHoliday == true &&
            selectedRequest?.nightOrHolidayDescription?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'شرایط زمانی درخواست',
            value:
                '${selectedRequest!.nightOrHolidayDescription!} - شامل افزایش هزینه',
          ),
        if (showCustomerInfo) ...[
          KeyValueRow(
            label: 'نام مشتری',
            value:
                '${selectedRequest?.firstName ?? '-'} ${selectedRequest?.lastName ?? ''}'
                    .trim(),
          ),
          KeyValueRow(
            label: 'شماره تماس مشتری',
            value: _customerMobile,
          ),
          KeyValueRow(
            label: 'آدرس',
            value: (selectedRequest?.aidAddress?.isNotEmpty ?? true)  ? '' :'-',
          ),
          if(selectedRequest?.aidAddress?.isNotEmpty ?? false)...[
            BodySmallText(
              text: selectedRequest?.aidAddress ?? '-',
              textAlign: TextAlign.start,
              fontWeight:  FontWeight.normal,
              fontSize: resolvedValueFontSize,
            )
          ]

        ],
        Space.h4,
        KeyValueRow(
          label: 'توضیحات مشتری',
          value: selectedRequest?.description ?? '-',
        ),
      ],
    );
  }

  String get _requestDateTime {
    final date = selectedRequest?.requestDateJalali?.trim();
    final time = selectedRequest?.requestTime?.trim();

    if ((date == null || date.isEmpty) && (time == null || time.isEmpty)) {
      return selectedRequest?.insertDateTimeJalali ?? '-';
    }

    if (date == null || date.isEmpty) return time ?? '-';
    if (time == null || time.isEmpty) return date;
    return '$date - $time';
  }

  String get _customerMobile {
    final mobile = selectedRequest?.customerMobileNumber?.trim().isNotEmpty == true
        ? selectedRequest!.customerMobileNumber
        : selectedRequest?.callMobileNumber;
    return mobile?.toLocalMobile() ?? '-';
  }

  String _firstNonBlank(Iterable<String?> values) {
    for (final value in values) {
      final text = value?.trim();
      if (text != null && text.isNotEmpty && text.toLowerCase() != 'null') {
        return text;
      }
    }
    return '-';
  }

  String _displayText(String? value) => _firstNonBlank([value]);

  ReliefRequestEntity? get reliefRequest =>
      selectedRequest is ReliefRequestEntity
          ? selectedRequest as ReliefRequestEntity
          : null;

  HomeServiceRequestEntity? get homeServiceRequest =>
      selectedRequest is HomeServiceRequestEntity
          ? selectedRequest as HomeServiceRequestEntity
          : null;
}
