import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/enums/service_assign_action.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/service_action_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/colored_info_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
Future<void> showAssignConfirmBottomSheet(BuildContext context) async {
  final  cubit = context.read<AssignAndCancelEmdadgarCubit>();

  await showServiceActionBottomSheet(
    context: context,
    cubit: cubit,
    title: 'تایید تخصیص',
    contentBuilder: (context) {
      return ConfirmAssignBottomForm(
        emdadgarEntity: cubit.selectedEmdadgar!,
        requestEntity: cubit.selectedRequest,
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
            submitTitle: 'تخصیص',
            isLoading: isLoading,
            submitButtonColor:
            cubit.selectedRequest?.serviceType?.serviceColor ??
                ServiceType.reliefService.serviceColor,
            onCancel: () => Navigator.pop(context),
            onSubmit: () => cubit.executeServiceAssign(
              ServiceAssignAction.assignEmdadgar,
            ),
          );
        },
      );
    },
  );
}

class ConfirmAssignBottomForm extends StatelessWidget {
  final BaseRequestEntity? requestEntity;
  final EmdadgarEntity emdadgarEntity;
  final TextEditingController descriptionController;

  const ConfirmAssignBottomForm({
    super.key,
    required this.requestEntity,
    required this.emdadgarEntity,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Space.h8,
        ColoredInfoCard(
          title: "درخواست ${requestEntity?.id ?? ''}",
          backgroundColor: Color(0xFF59168b).withAlpha(25),
          borderColor: Color(0xFF59168b),
          titleColor: Color(0xFF59168b),
          items: [
            ColoredInfoCardItem.text(
              value:
                  "${requestEntity?.firstName ?? ''} ${requestEntity?.lastName ?? ''} - ${requestEntity?.carName ?? ''}",
            ),
            ColoredInfoCardItem.text(
              value: (requestEntity is ReliefRequestEntity)
                  ? (requestEntity as ReliefRequestEntity).emdadServiceTitle ??
                        '-'
                  : '-',
            ),
          ],
        ),
        Space.h8,
        ColoredInfoCard(
          title: 'امداد رسان انتخابی',
          backgroundColor: Color(0xFF00966d).withAlpha(25),
          borderColor: Color(0xFF00966d),
          titleColor: Color(0xFF00966d),
          items: [
            ColoredInfoCardItem.text(value: emdadgarEntity.agencyName ?? ''),
            ColoredInfoCardItem.text(
              value:
                  "${emdadgarEntity.khodroTypeText} / ${emdadgarEntity.navganTypeText}",
            ),
            ColoredInfoCardItem.text(
              value:
                  "فاصله: ${emdadgarEntity.distanceKmToOrigin} کیلومتر | زمان ${emdadgarEntity.runtimeType} دقیقه",
            ),
          ],
        ),
        Space.h16,
        TextFormFieldWidget(
          labelText: "توضیحات تخصیص",
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
