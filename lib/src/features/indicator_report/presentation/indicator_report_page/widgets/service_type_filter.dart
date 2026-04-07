import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/cubit/indicator_report_cubit.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/widgets/indicator_filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bullet_point/bullet_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceTypeFilter extends StatelessWidget {
  const ServiceTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PopupMenuButton<ServiceType>(
        onSelected: (value) {
          context.read<IndicatorReportCubit>().setServiceType(value);
        },
        itemBuilder: (context) {
          return ServiceType.values.map((type) {
            return PopupMenuItem<ServiceType>(
              value: type,
              child: Row(
                children: [
                  BulletPoint(color: type.serviceColor),
                  Space.w8,
                  Text(type.label),
                ],
              ),
            );
          }).toList();
        },
        child: BlocBuilder<IndicatorReportCubit, IndicatorReportState>(
          buildWhen: (_, __) => true,
          builder: (context, state) {
            final cubit = context.read<IndicatorReportCubit>();

            final selected = cubit.selectedServiceType;

            return IndicatorFilterButton(
              title: selected?.label ?? "نوع خدمت",
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
