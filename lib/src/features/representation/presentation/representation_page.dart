import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/representation/presentation/cubit/representation_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepresentationPage extends StatelessWidget {
  static const path = "/representation-page";
  static const name = "representation-page";

  const RepresentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RepresentationCubit>()..init(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RepresentationCubit>();
    return BlocListener<RepresentationCubit, RepresentationState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: const MainAppBar(title: "نمایندگی"),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: Column(children: []),
        ),
      ),
    );
  }
}
