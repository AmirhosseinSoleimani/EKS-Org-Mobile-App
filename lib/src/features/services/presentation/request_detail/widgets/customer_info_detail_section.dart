import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class CustomerInfoDetailSection extends StatelessWidget {
  const CustomerInfoDetailSection({
    super.key,
    required this.cubit,
  });

  final RequestDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyValueRow(
          label: "نام",
          value: cubit.selectedRequest?.firstName ?? "-",
        ),
        KeyValueRow(
          label: "نام خانوادگی",
          value: cubit.selectedRequest?.lastName ?? "-",
        ),
        KeyValueRow(
          label: "کد ملی",
          value: cubit.selectedRequest?.nationalNumber ?? "-",
        ),
        KeyValueRow(
          label: "شماره موبایل",
          value: cubit.selectedRequest?.customerMobileNumber ?? "-",
        ),
        KeyValueRow(
          label: "نوع شخص",
          value: cubit.selectedRequest?.personTypeTitle ?? "-",
        ),
        KeyValueRow(
          label: "جنسیت",
          value: cubit.selectedRequest?.genderTitle ?? "-",
        ),
      ],
    );
  }
}
