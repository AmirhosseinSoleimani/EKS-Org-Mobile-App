import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_cubit.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_form.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_submit_controller.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_form_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeneralContentFormPage extends StatelessWidget {
  static const path = '/general-content-form-page';
  static const name = 'general-content-form-page';

  const GeneralContentFormPage({
    super.key,
    this.content,
  });

  final GeneralContentEntity? content;

  bool get isEditMode => content?.id != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GeneralContentCubit>()..initForm(content),
      child: _GeneralContentFormView(
        content: content,
        isEditMode: isEditMode,
      ),
    );
  }
}

class _GeneralContentFormView extends StatefulWidget {
  const _GeneralContentFormView({
    required this.content,
    required this.isEditMode,
  });

  final GeneralContentEntity? content;
  final bool isEditMode;

  @override
  State<_GeneralContentFormView> createState() =>
      _GeneralContentFormViewState();
}

class _GeneralContentFormViewState extends State<_GeneralContentFormView> {
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
            appBar: SimpleAppBar(
              title: widget.isEditMode
                  ? 'ویرایش بخشنامه'
                  : 'ثبت بخشنامه جدید',
            ),
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
                child: GeneralContentForm(
                  state: state,
                  submitController: _submitController,
                  initialContent: widget.content,
                  onSubmit: cubit.submitContent,
                  onSuccess: () => context.pop(true),
                ),
              ),
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: widget.isEditMode ? 'ویرایش' : 'ثبت',
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
