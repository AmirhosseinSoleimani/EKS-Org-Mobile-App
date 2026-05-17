import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/bottom_sheet/bottom_sheet_header.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showNonCooperationBottomSheet(BuildContext context) async {
  final cubit = context.read<AssignAndCancelEmdadgarCubit>();

  cubit.initNonCooperation();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    builder: (context) {

      return BlocProvider.value(
        value: cubit,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Column(
              children: [
                BottomSheetHeader(title: "عدم همکاری"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: NonCooperationBottomSheetForm(
                      reasons: cubit.ReasonListNotifier,
                      selectedReason: cubit.selectedCancelReason,
                      onReasonSelected: cubit.setSelectedCancelReason,
                      descriptionController: cubit.descriptionController,
                    ),
                  ),
                ),

                BlocBuilder<
                  AssignAndCancelEmdadgarCubit,
                  AssignAndCancelEmdadgarState
                >(
                  builder: (context, state) {
                    final isLoading =
                        state.whenOrNull(
                          submitNonCooperationLoading: () => true,
                        ) ??
                        false;

                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: SubmitCancelButtons(
                        submitTitle: 'ثبت',
                        isLoading: isLoading,
                        onCancel: () => Navigator.pop(context),
                        onSubmit: () => cubit.executeServiceAssign(
                          ServiceAssignAction.nonCooperation,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
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
          isLoading: reasons.value.isEmpty,
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
