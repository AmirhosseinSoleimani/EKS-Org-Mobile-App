import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/widgets/home_service_package_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showHomeServicePackageBottomSheet(BuildContext context) async {
  final cubit = context.read<HomeServiceEvaluationCubit>();

  cubit.openAddPackageSheet();

  await BottomSheetMessage.showCustom(
    context: context,
    maxHeight: MediaQuery.of(context).size.height * 0.9,
    backgroundColor: Colors.white,
    content: BlocProvider.value(
      value: cubit,
      child: const HomeServicePackageBottomSheet(),
    ),
  );
}