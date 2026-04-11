import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class RequestDetailSection extends StatelessWidget {
  const RequestDetailSection({
    super.key,
    required this.cubit,
  });

  final RequestDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyValueRow(
          label: "شماره درخواست",
          value: cubit.selectedRequest.trackCode.toString(),
        ),
        KeyValueRow(
          label: "زمان ثبت",
          value:
          "${cubit.selectedRequest.requestDateJalali} - ${cubit.selectedRequest.requestTime}",
        ),
        KeyValueRow(
          label: cubit.isRelief ? "ایراد خودرو" : "سرویس انتخاب شده",
          value: cubit.isRelief
              ? (cubit.selectedRequest as ReliefRequestEntity).defectTitle
              : (cubit.selectedRequest as HomeServiceRequestEntity)
              .emdadProductTitle ??
              "-",
        ),
        if (cubit.selectedRequest is ReliefRequestEntity)
          KeyValueRow(
            label: "وضعیت خودرو",
            value: (cubit.selectedRequest as ReliefRequestEntity)
                .hamlReasonTitle ??
                "-",
          ),
        if (cubit.selectedRequest is ReliefRequestEntity)
          KeyValueRow(
            label: "وضعیت چرخ‌ها",
            value: (cubit.selectedRequest as ReliefRequestEntity)
                .wheelQuestionTitle ??
                "-",
          ),
        KeyValueRow(
          label: "توضیحات مشتری",
          value: cubit.selectedRequest.description ?? "-",
        ),
      ],
    );
  }
}
