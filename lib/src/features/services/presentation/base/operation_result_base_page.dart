import 'package:eks_sana_plus_org/src/features/services/presentation/base/cubit/operation_base_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/base/cubit/operation_base_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class OperationResultBasePage<TCubit extends OperationBaseCubit<TData>, TData>
    extends StatelessWidget {
  final String title;
  final TCubit Function() createCubit;
  final Widget Function(BuildContext context) loadedBuilder;

  const OperationResultBasePage({
    super.key,
    required this.title,
    required this.createCubit,
    required this.loadedBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createCubit()..init(),
      child: Scaffold(
        appBar: SimpleAppBar(title: title),
        body: BlocBuilder<TCubit, OperationBaseState<TData>>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: () => loadedBuilder(context),
              loadingMore: () => loadedBuilder(context),
              error: (msg) => Center(child: Text(msg)),
              connectionError: () => const Center(child: Text("خطا در اتصال")),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
