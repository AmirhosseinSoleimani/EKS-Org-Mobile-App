import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReasonCancelRequestContent extends StatelessWidget {
  final List<CancelReasonEntity> cancelReasons;
  const ReasonCancelRequestContent({super.key, required this.cancelReasons});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<RequestDetailCubit, RequestDetailState>(
      builder: (context, state) {
        final cubit = context.read<RequestDetailCubit>();

        final selectedReason = cubit.selectedReason;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TitleLargeText(
                text: 'لغو درخواست',
                fontSize: AppSize.s16,
                color: colorScheme.onTertiary,
              ),
            ),
            Space.h16,

            Center(
              child: TitleLargeText(
                text: 'علت لغو درخواست تان چیست؟',
                fontSize: AppSize.s16,
                color: colorScheme.onPrimaryFixed,
              ),
            ),
            Space.h32,

            DropdownButtonFormField<int>(
              value: selectedReason?.id,
              isExpanded: true,
              hint: const BodyMediumText(text: 'انتخاب کنید'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  borderSide:
                  BorderSide(color: colorScheme.tertiaryFixed, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  borderSide:
                  BorderSide(color: colorScheme.tertiaryFixed, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  borderSide:
                  BorderSide(color: colorScheme.tertiaryFixed, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  borderSide: BorderSide(color: colorScheme.error, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  borderSide: BorderSide(color: colorScheme.error, width: 1),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: cancelReasons.map((reason) {
                return DropdownMenuItem<int>(
                  value: reason.id,
                  child: BodyMediumText(text: reason.title ?? '-'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  final selected = cancelReasons.firstWhere((r) => r.id == value);
                  cubit.setSelectedReason(selected);
                }
              },
            ),


            Space.h16,

            TextFormFieldWidget(
              controller: cubit.reasonTextController,
              maxLines: 4,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s8),
                borderSide:
                BorderSide(color: colorScheme.tertiaryFixed, width: 1),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              mandatory: true,
              labelText: 'توضیحات',
              hintText: 'توضیح لغو درخواست..',
            ),
          ],
        );
      },
    );
  }
}
