import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_state.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/forms/rescuer_contact_form.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/forms/rescuer_cooperation_form.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/forms/rescuer_documents_form.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/forms/rescuer_identity_form.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_actions.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_stepper.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/views/add_rescuer_success_view.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_full_screen_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRescuerResult {
  const AddRescuerResult({required this.rescuerId, this.viewProfile = false});

  final int rescuerId;
  final bool viewProfile;
}

class AddRescuerPage extends StatelessWidget {
  const AddRescuerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddRescuerCubit>()..init(),
      child: const _AddRescuerView(),
    );
  }
}

class _AddRescuerView extends StatelessWidget {
  const _AddRescuerView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddRescuerCubit>();
    return BlocConsumer<AddRescuerCubit, AddRescuerState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.connectionError != current.connectionError,
      listener: (context, state) => _handleError(context, state, cubit),
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.isLoading != current.isLoading ||
          previous.isLoadingCities != current.isLoadingCities ||
          previous.createdId != current.createdId,
      builder: (context, state) {
        if (state.createdId != null) {
          return AddRescuerSuccessView(
            id: int.tryParse(state.createdId!) ?? 0,
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          appBar: const RescuerFullScreenSheetAppBar(
            title: 'افزودن امدادرسان',
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: RescuerStepper(current: state.currentStep),
              ),
              Expanded(
                child: state.isLoadingCities
                    ? const Center(child: LoadingWidget())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                        child: _CurrentStepForm(
                          step: state.currentStep,
                          cubit: cubit,
                        ),
                      ),
              ),
            ],
          ),
          bottomNavigationBar: RescuerFormActions(
            step: state.currentStep,
            loading: state.isLoading,
            onNext: state.currentStep == 3 ? cubit.submit : cubit.next,
            onPrevious: state.currentStep == 0
                ? () => Navigator.of(context).pop()
                : cubit.previous,
          ),
        );
      },
    );
  }

  void _handleError(
    BuildContext context,
    AddRescuerState state,
    AddRescuerCubit cubit,
  ) {
    if (state.errorMessage != null) {
      BottomSheetMessage.showError(
        context: context,
        data: BottomSheetMessageModel(
          title: 'خطا',
          message: state.errorMessage!,
        ),
        onButtonTap: () => Navigator.of(context).pop(),
      );
      return;
    }

    if (state.connectionError) {
      BottomSheetMessage.showCustom(
        context: context,
        content: NoInternetBottomSheet(onRetry: cubit.init),
        actionWidget: const SizedBox.shrink(),
        isDismissible: false,
        enableDrag: false,
      );
    }
  }
}

class _CurrentStepForm extends StatelessWidget {
  const _CurrentStepForm({required this.step, required this.cubit});

  final int step;
  final AddRescuerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      0 => RescuerIdentityForm(cubit: cubit),
      1 => RescuerContactForm(cubit: cubit),
      2 => RescuerCooperationForm(cubit: cubit),
      _ => RescuerDocumentsForm(cubit: cubit),
    };
  }
}
