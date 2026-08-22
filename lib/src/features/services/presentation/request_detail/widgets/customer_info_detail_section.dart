import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/enums/disability.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class CustomerInfoDetailSection extends StatelessWidget {
  const CustomerInfoDetailSection({
    super.key,
    required this.cubit,
  });

  final RequestDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    final request = cubit.selectedRequest;
    final disabilityValue = request?.customerDisability;

    return Column(
      children: [
        KeyValueRow(
          label: 'نام',
          value: request?.firstName ?? '-',
        ),
        KeyValueRow(
          label: 'نام خانوادگی',
          value: request?.lastName ?? '-',
        ),
        KeyValueRow(
          label: 'کد ملی',
          value: request?.nationalCode ?? '-',
        ),
        KeyValueRow(
          label: 'شماره موبایل',
          value: _displayMobile,
        ),
        KeyValueRow(
          label: 'نوع شخص',
          value: request?.personTypeTitle ?? '-',
        ),
        KeyValueRow(
          label: 'جنسیت',
          value: request?.genderTitle ?? '-',
        ),
        if (request?.foreigner != null)
          KeyValueRow(
            label: 'اتباع خارجی',
            value: request!.foreigner! ? 'بله' : 'خیر',
          ),
        KeyValueRow(
          label: 'استان',
          value: request?.provinceName ?? '-',
        ),
        KeyValueRow(
          label: 'شهر',
          value: request?.cityName ?? '-',
        ),
        KeyValueRow(
          label: 'آدرس',
          value: request?.aidAddress ?? '-',
        ),
        if (disabilityValue != null)
          KeyValueRow(
            label: 'محدودیت جسمانی',
            value: Disability.fromValue(disabilityValue).title,
          ),
        if (request?.customerDisabilityDesc?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'توضیحات محدودیت',
            value: request!.customerDisabilityDesc!,
          ),
      ],
    );
  }

  String get _displayMobile {
    final request = cubit.selectedRequest;
    final mobile = request?.customerMobileNumber?.trim().isNotEmpty == true
        ? request!.customerMobileNumber
        : request?.callMobileNumber;
    return mobile?.toLocalMobile() ?? '-';
  }
}
