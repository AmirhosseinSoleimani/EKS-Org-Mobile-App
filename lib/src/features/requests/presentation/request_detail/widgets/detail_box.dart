
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/invoice_button_widget.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/widgets/section_container.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/status_row.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  final RequestEntity selectedRequest;

  const DetailBox(this.selectedRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceType = selectedRequest.getInvoiceType();
    return SectionContainer(
      padding: const EdgeInsets.only(
        left: AppPadding.p16,
        right: AppPadding.p16,
        top: AppPadding.p14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusRow(
              item: selectedRequest,
              mainAxisAlignment: MainAxisAlignment.center),
          Space.h8,
          _RequestDetailInfoRow(
            title: 'نام درخواست دهنده',
            value: '${selectedRequest.firstName} ${selectedRequest.lastName}',
          ),
          _RequestDetailInfoRow(
            title: 'شماره درخواست',
            value: '${selectedRequest.requestNo}',
          ),
          _RequestDetailInfoRow(
            title: 'وضعیت درخواست',
            value: '${selectedRequest.statusTitle}',
          ),
          _RequestDetailInfoRow(
            title: 'تاریخ ثبت',
            value: '${selectedRequest.submitDate}',
          ),
          _RequestDetailInfoRow(
            title: 'زمان ثبت',
            value: '${selectedRequest.submitTime?.to12HourFormat()}',
          ),
          _RequestDetailInfoRow(
            title: 'ایراد خودرو',
            value: selectedRequest.defectTitle ?? '-',
          ),
          _RequestDetailInfoRow(
            title: 'توضیحات درخواست',
            value: selectedRequest.defectDescription ?? '-',
            singleLine: (selectedRequest.defectDescription == null),
          ),
          Space.h16,
          if (invoiceType != null)
            InvoiceButtonWidget(
                selectedRequest: selectedRequest, invoiceType: invoiceType),
          Space.h16,
        ],
      ),
    );
  }
}

class _RequestDetailInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final bool singleLine;

  const _RequestDetailInfoRow({
    required this.title,
    required this.value,
    this.singleLine = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final children = [
      BodySmallText(
        text: title,
        fontSize: AppSize.s12,
        color: theme.colorScheme.tertiary,
      ),
      Flexible(
        child: BodySmallText(
          text: value,
          color: theme.colorScheme.onTertiaryFixed,
          textAlign: singleLine ? TextAlign.end : TextAlign.start,
        ),
      ),
    ];

    final content = singleLine
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              children.first,
              const SizedBox(height: AppSize.s12),
              children.last,
            ],
          );

    return Padding(
      padding: const EdgeInsets.all(AppSize.s6),
      child: content,
    );
  }
}
