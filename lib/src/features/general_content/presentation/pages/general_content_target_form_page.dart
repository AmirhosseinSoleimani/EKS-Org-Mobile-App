import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_cubit.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_submit_controller.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_target_form.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeneralContentTargetFormPage extends StatelessWidget {
  static const path = '/general-content-target-form-page';
  static const name = 'general-content-target-form-page';

  const GeneralContentTargetFormPage({
    super.key,
    required this.content,
  });

  final GeneralContentEntity content;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GeneralContentCubit>()..initTargetForm(content),
      child: _GeneralContentTargetFormView(content: content),
    );
  }
}

class _GeneralContentTargetFormView extends StatefulWidget {
  const _GeneralContentTargetFormView({required this.content});

  final GeneralContentEntity content;

  @override
  State<_GeneralContentTargetFormView> createState() =>
      _GeneralContentTargetFormViewState();
}

class _GeneralContentTargetFormViewState
    extends State<_GeneralContentTargetFormView> {
  final _submitController = GeneralContentSubmitController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GeneralContentCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<GeneralContentCubit, GeneralContentState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
            cubit.clearMessages();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: const SimpleAppBar(title: 'افزودن گیرنده'),
            body: SafeArea(
              top: false,
              bottom: false,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: GeneralContentTargetForm(
                  content: widget.content,
                  state: state,
                  submitController: _submitController,
                  onTargetTypeChanged: cubit.changeTargetType,
                  onSubmit: cubit.submitTarget,
                  onSuccess: () => context.pop(true),
                ),
              ),
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'افزودن',
              cancelTitle: 'انصراف',
              isSubmitting: state.isSubmitting,
              onSubmit: _submitController.submit,
              onCancel: () => context.pop(),
            ),
          );
        },
      ),
    );
  }
}
