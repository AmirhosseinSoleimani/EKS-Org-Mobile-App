import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/enums/service_assign_action.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/service_action_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showNonCooperationBottomSheet(BuildContext context) async {
  final cubit = context.read<AssignAndCancelEmdadgarCubit>();
  await showServiceActionBottomSheet(
    context: context,
    cubit: cubit,
    title: 'عدم همکاری',
    contentBuilder: (context) {
      return NonCooperationBottomSheetForm(
        reasons: cubit.reasonListNotifier,
        selectedReason: cubit.selectedCancelReason,
        onReasonSelected: cubit.setSelectedCancelReason,
        descriptionController: cubit.descriptionController,
      );
    },
    actionsBuilder: (context) {
      return BlocBuilder<
          AssignAndCancelEmdadgarCubit,
          AssignAndCancelEmdadgarState
      >(
        builder: (context, state) {
          final isLoading =
              state.whenOrNull(submitLoading: () => true) ?? false;

          return SubmitCancelButtons(
            submitButtonColor:
            cubit.selectedRequest?.serviceType?.serviceColor ??
                ServiceType.reliefService.serviceColor,
            submitTitle: 'ثبت',
            isLoading: isLoading,
            onCancel: () => Navigator.pop(context),
            onSubmit: () =>
                cubit.executeServiceAssign(
                  ServiceAssignAction.nonCooperation,
                ),
          );
        },
      );
    },
  );
}

class NonCooperationBottomSheetForm extends StatelessWidget {
  final ValueNotifier<List<CancelRequestReasonEntity>> reasons;
  final ValueNotifier<CancelRequestReasonEntity?> selectedReason;
  final ValueChanged<CancelRequestReasonEntity?> onReasonSelected;
  final TextEditingController descriptionController;

  const NonCooperationBottomSheetForm({
    super.key,
    required this.reasons,
    required this.selectedReason,
    required this.onReasonSelected,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSelector<CancelRequestReasonEntity>(
          label: "دلیل عدم همکاری",
          placeholder: "انتخاب دلیل عدم همکاری",
          selectedNotifier: selectedReason,
          items: reasons.value,
          enabled: reasons.value.isNotEmpty,
          itemTitleBuilder: (item) => item.title ?? "",
          onSelect: onReasonSelected,
        ),
        Space.h16,
        TextFormFieldWidget(
          labelText: "توضیحات",
          controller: descriptionController,
          autofocus: false,
          textInputType: TextInputType.text,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.done,
          maxLines: 3,
        ),
      ],
    );
  }
}
