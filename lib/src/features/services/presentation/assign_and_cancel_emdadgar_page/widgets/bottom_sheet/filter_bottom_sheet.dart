import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/filter/assign_filter_switch_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/filter/emdadgar_filter_form.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/filter/saipa_yadak_agency_filter_form.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum AssignFilterType { emdadgar, agency }

Future<void> showFilterBottomSheet(BuildContext context) async {
  final cubit = context.read<AssignAndCancelEmdadgarCubit>();
  final colorScheme = Theme.of(context).colorScheme;
  BottomSheetMessage.showCustom(
    backgroundColor: Colors.white,
    context: context,
    content: AssignFilterBottomSheetContent(cubit: cubit),
    actionWidget: Row(
      children: [
        Expanded(
          flex: 60,
          child: InkwellButtonWidget(
            title: 'اعمال فیلتر',
            backgroundColor: cubit.selectedRequest?.serviceType?.serviceColor,
            onTap: () {
              context.pop();
              cubit.applyFilterOnEmdadgarList();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 60,
          child: InkwellButtonWidget(
            title: 'پاک کردن همه',
            backgroundColor: Colors.transparent,
            borderColor: colorScheme.onPrimaryFixed,
            titleColor: colorScheme.onPrimaryFixed,
            onTap: cubit.clearFilterFields,
          ),
        ),
      ],
    ),
  );
}

class AssignFilterBottomSheetContent extends StatefulWidget {
  final AssignAndCancelEmdadgarCubit cubit;

  const AssignFilterBottomSheetContent({super.key, required this.cubit});

  @override
  State<AssignFilterBottomSheetContent> createState() =>
      _AssignFilterBottomSheetContentState();
}

class _AssignFilterBottomSheetContentState
    extends State<AssignFilterBottomSheetContent> {
  AssignFilterType selectedType = AssignFilterType.emdadgar;

  bool get _isEmdadgarSelected => selectedType == AssignFilterType.emdadgar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(text: 'جستجو و فیلتر', fontSize: 15),
        Space.h16,
        AssignFilterSwitchBox(
          cubit: widget.cubit,
          selectedType: selectedType,
          onChanged: (value) {
            setState(() {
              selectedType = value;
            });
          },
        ),
        Space.h24,
        Stack(
          children: [
            _AnimatedFilterFormVisibility(
              visible: _isEmdadgarSelected,
              slideBegin: const Offset(0.04, 0),
              child: EmdadgarFilterForm(cubit: widget.cubit),
            ),
            _AnimatedFilterFormVisibility(
              visible: !_isEmdadgarSelected,
              slideBegin: const Offset(-0.04, 0),
              child: SaipaYadakAgencyFilterForm(cubit: widget.cubit),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimatedFilterFormVisibility extends StatelessWidget {
  final bool visible;
  final Offset slideBegin;
  final Widget child;

  const _AnimatedFilterFormVisibility({
    required this.visible,
    required this.slideBegin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: ExcludeSemantics(
        excluding: !visible,
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: AnimatedSlide(
            offset: visible ? Offset.zero : slideBegin,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            child: child,
          ),
        ),
      ),
    );
  }
}
