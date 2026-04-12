import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/car_plate.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class CarInfoDetailSection extends StatelessWidget {
  final RequestDetailCubit cubit;

  const CarInfoDetailSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final request = cubit.selectedRequest;
    final carTag = request.licensePlate;

    return Column(
      children: [
        KeyValueRow(
          label: "نام",
          value: request.carName,
        ),
        KeyValueRow(
          label: "شماره شاسی",
          value: request.chassisNumber ?? "-",
        ),
        KeyValueRow(
          label: "شماره موتور",
          value: request.carEngineNumber ?? "-",
        ),
        KeyValueRow(
          label: "رنگ",
          value: request.carColorTitle ?? "-",
        ),
        KeyValueRow(
          label: "سال ساخت",
          value: request.carProductionYear.toString(),
        ),
        KeyValueRow(
          label: "کیلومتر مشتری",
          value: request.kilometer?.toString() ?? "-",
        ),
        if (request is ReliefRequestEntity) ...[
          KeyValueRow(
            label: "کیلومتر امدادرسان",
            value: request.emdadgarAssignDistanceTitle?.toString() ?? "-",
          ),
        ],
        CarPlate(
          firstCarTag: carTag.isNotEmpty ? carTag[0] : '',
          secondCarTag: carTag.length > 1 ? carTag[1] : '',
          thirdCarTag: carTag.length > 2 ? carTag[2] : '',
          fourthCarTag: carTag.length > 3 ? carTag[3] : '',
          textStyle: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: AppSize.s14),
        ),
      ],
    );
  }
}
