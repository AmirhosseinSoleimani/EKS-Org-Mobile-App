
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/cubit/update_request_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SubmitButtonWidget({super.key, required this.formKey,});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateRequestCubit>();
    return ValueListenableBuilder<bool>(
      valueListenable: cubit.validationNotifier,
      builder: (_, isValid, _) {
        return InkwellButtonWidget(
          onTap: () => cubit.updateServiceRequest(),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,
          showLoading: cubit.validationNotifier.value,
          title: 'ذخیره تغییرات',
        );
      },
    );
  }
}