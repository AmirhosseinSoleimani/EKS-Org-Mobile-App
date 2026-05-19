import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/enums/service_assign_action.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/bottom_sheet/bottom_sheet_header.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showCancelMissionBottomSheet(BuildContext context) async {
  final cubit = context.read<AssignAndCancelEmdadgarCubit>();

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
                BottomSheetHeader(title: "لغو ماموریت"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CancelMissionBottomSheetForm(cubit: cubit),
                  ),
                ),

                BlocBuilder<
                  AssignAndCancelEmdadgarCubit,
                  AssignAndCancelEmdadgarState
                >(
                  builder: (context, state) {
                    final isLoading =
                        state.whenOrNull(submitLoading: () => true) ?? false;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                      child: SubmitCancelButtons(
                        submitButtonColor: ColorLightManager.error,
                        submitTitle: 'لغو ماموریت',
                        isLoading: isLoading,
                        onCancel: () => Navigator.pop(context),
                        onSubmit: () => cubit.executeServiceAssign(
                          ServiceAssignAction.cancelMission,
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

class CancelMissionBottomSheetForm extends StatelessWidget {
  final AssignAndCancelEmdadgarCubit cubit;

  const CancelMissionBottomSheetForm({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSelector<CancelRequestReasonEntity>(
          label: "دلیل لغو",
          placeholder: "انتخاب دلیل لغو",
          selectedNotifier: cubit.selectedCancelReason,
          items: cubit.reasonListNotifier.value,
          enabled: cubit.reasonListNotifier.value.isNotEmpty,
          itemTitleBuilder: (item) => item.title ?? "",
          onSelect: cubit.setSelectedCancelReason,
        ),
        Space.h16,
        TextFormFieldWidget(
          labelText: "توضیحات",
          controller: cubit.descriptionController,
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
