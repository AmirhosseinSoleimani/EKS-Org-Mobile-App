import 'package:eks_sana_plus_org/src/features/services/presentation/base/cubit/operation_base_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/base/cubit/operation_base_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationResultBasePage<TCubit extends OperationBaseCubit<TData>, TData>
    extends StatelessWidget {
  final String title;
  final TCubit Function() createCubit;
  final Widget Function(BuildContext context) loadedBuilder;

  // NEW ↓↓↓
  final Function(BuildContext context, BottomSheetMessageModel)? onError;
  final Function(BuildContext context)? onConnectionError;

  const OperationResultBasePage({
    super.key,
    required this.title,
    required this.createCubit,
    required this.loadedBuilder,
    this.onError,
    this.onConnectionError,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createCubit()..init(),
      child: BlocListener<TCubit, OperationBaseState<TData>>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              if (onError != null) {
                onError!(context, message);
              }
            },
            connectionError: () {
              if (onConnectionError != null) {
                onConnectionError!(context);
              }
            },
          );
        },
        child: Scaffold(
          appBar: SimpleAppBar(title: title),
          body: BlocBuilder<TCubit, OperationBaseState<TData>>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: () => loadedBuilder(context),
                loadingMore: () => loadedBuilder(context),
                orElse: () => const SizedBox(),
              );
            },
          ),
        ),
      ),
    );
  }
}
