import 'package:eks_sana_plus_org/src/common/utils/car_plate_parser.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/car_plate.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class CarInfoDetailSection extends StatelessWidget {
  final RequestDetailCubit cubit;

  const CarInfoDetailSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final request = cubit.selectedRequest;
    final carTag = request?.licensePlate ?? '';
    final plate = CarPlateParser.parse(carTag);

    return Column(
      children: [
        KeyValueRow(
          label: 'نام',
          value: request?.carName ?? '-',
        ),
        if (request?.carFactoryTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'کارخانه',
            value: request!.carFactoryTitle!,
          ),
        if (request?.carGroupTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'گروه خودرو',
            value: request!.carGroupTitle!,
          ),
        if (request?.vehicleUsageTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'نوع کاربری',
            value: request!.vehicleUsageTitle!,
          ),
        if (request?.weightGroupTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'گروه وزنی',
            value: request!.weightGroupTitle!,
          ),
        KeyValueRow(
          label: 'شماره شاسی',
          value: request?.chassisNumber ?? '-',
        ),
        KeyValueRow(
          label: 'شماره موتور',
          value: request?.carEngineNumber ?? '-',
        ),
        KeyValueRow(
          label: 'رنگ',
          value: request?.carColorTitle ?? '-',
        ),
        KeyValueRow(
          label: 'سال ساخت',
          value: request?.carProductionYear?.toString() ?? '-',
        ),
        KeyValueRow(
          label: 'کیلومتر مشتری',
          value: request?.kilometer?.toString() ?? '-',
        ),
        KeyValueRow(
          label: request?.isHomeService == true
              ? 'کیلومتر اعلامی امدادرسان'
              : 'کیلومتر امدادرسان',
          value: request?.emdadgarEvaluationKilometer?.toString() ?? '-',
        ),
        SizedBox(
          width: 120,
          height: 34,
          child: CarPlate(
            firstCarTag: plate.first,
            secondCarTag: plate.second,
            thirdCarTag: plate.third,
            fourthCarTag: plate.fourth,
            textStyle: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: AppSize.s12),
          ),
        ),
      ],
    );
  }
}
