import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'presentation/cubit/emdad_vehicle_cubit.dart';

class EmdadVehiclePage extends StatelessWidget {
  static const path = '/emdad-vehicle-page';
  static const name = 'emdad-vehicle-page';

  const EmdadVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadVehicleCubit>(),
      child: const EmdadVehiclePageView(),
    );
  }
}

class EmdadVehiclePageView extends StatelessWidget {
  const EmdadVehiclePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadVehicleCubit>();

    return BlocConsumer<EmdadVehicleCubit, EmdadVehicleState>(
      listenWhen: (previous, current) {
        return true;
       /* return current.maybeWhen(
          error: (_, __) => true,
          connectionError: (_) => true,
          orElse: () => false,
        );*/
      },
      listener: (context, state) {
       /* state.whenOrNull(
          error: (data, message) {
            BottomSheetMessage.showError(
              context: context,
              data: message,
              onButtonTap: () {
                context.pop();
                if (cubit.hasRetryAction) {
                  cubit.retryLastAction();
                }
              },
            );
          },
          connectionError: (data) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.hasRetryAction
                    ? cubit.retryLastAction
                    : () => context.pop(),
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );*/
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const MainAppBar(title: 'خودرو امدادی'),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [Space.h8]),
            ),
          ),
        );
      },
    );
  }
}
