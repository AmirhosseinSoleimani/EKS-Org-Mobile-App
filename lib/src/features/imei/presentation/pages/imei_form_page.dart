import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_cubit.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_state.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/widgets/imei_form_view.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImeiFormPage extends StatelessWidget {
  static const addPath = '/imei-add-page';
  static const addName = 'imei-add-page';
  static const editPath = '/imei-edit-page';
  static const editName = 'imei-edit-page';

  const ImeiFormPage({
    super.key,
    required this.isEdit,
    this.item,
  });

  final bool isEdit;
  final ImeiInfoEntity? item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ImeiCubit>()..initForm(item: isEdit ? item : null),
      child: _ImeiFormPageView(isEdit: isEdit),
    );
  }
}

class _ImeiFormPageView extends StatelessWidget {
  const _ImeiFormPageView({required this.isEdit});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImeiCubit, ImeiState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        final error = state.errorMessage;
        if (error?.trim().isNotEmpty == true) {
          SnakeBarWidget.showError(context: context, message: error!);
        }

        if (state.successMessage?.trim().isNotEmpty == true) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        if (isEdit && state.isGettingDetail) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: SimpleActionBar(title: 'ویرایش IMEI'),
              body: const Center(child: LoadingWidget()),
            ),
          );
        }

        return ImeiFormView(isEdit: isEdit);
      },
    );
  }
}
