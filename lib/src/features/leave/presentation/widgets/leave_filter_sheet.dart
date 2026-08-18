import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_type.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveFilterSheet extends StatelessWidget {
  const LeaveFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeaveCubit>();

    return BlocBuilder<LeaveCubit, LeaveState>(
      builder: (context, state) {
        return FilterBottomSheetScaffold(
          title: 'فیلترها',
          onApply: () {
            Navigator.of(context).pop();
            cubit.applyFilters();
          },
          onClear: () {
            Navigator.of(context).pop();
            cubit.clearFilters();
          },
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: cubit.agencyCodeController,
                labelText: 'کد نمایندگی',
                hintText: 'کد نمایندگی',
                textInputType: TextInputType.number,
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: cubit.emdadgarNameController,
                hintText: 'امدادرسان',
                labelText: 'امدادرسان',
              ),
              Space.h12,
              EkDropDown(
                LeaveCubit.typeOptions.map((item) => item.title).toList(),
                label: 'نوع مرخصی',
                selectedItem: _leaveTypeTitle(state.selectedType),
                onItemValue: (value) {
                  final option = LeaveCubit.typeOptions.firstWhere(
                    (item) => item.title == value,
                  );
                  cubit.onTypeChanged(option.type);
                },
              ),
              Space.h12,
              EkDropDown(
                ['همه', ...state.reasons.map(_reasonTitle)],
                key: ValueKey(
                  'leave-main-reasons-${state.reasons.map(_reasonTitle).join('|')}',
                ),
                label: 'دلیل اصلی',
                selectedItem: state.selectedMainReason == null
                    ? 'همه'
                    : _reasonTitle(state.selectedMainReason!),
                onItemValue: (value) {
                  cubit.onMainReasonChanged(
                    value == 'همه' ? null : _findReason(state.reasons, value),
                  );
                },
              ),
              if (state.secondaryReasons.isNotEmpty) ...[
                Space.h12,
                EkDropDown(
                  ['همه', ...state.secondaryReasons.map(_reasonTitle)],
                  key: ValueKey(
                    'leave-secondary-reasons-${state.secondaryReasons.map(_reasonTitle).join('|')}',
                  ),
                  label: 'دلیل فرعی',
                  selectedItem: state.selectedSecondaryReason == null
                      ? 'همه'
                      : _reasonTitle(state.selectedSecondaryReason!),
                  onItemValue: (value) {
                    cubit.onSecondaryReasonChanged(
                      value == 'همه'
                          ? null
                          : _findReason(state.secondaryReasons, value),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  String _leaveTypeTitle(LeaveType value) {
    return LeaveCubit.typeOptions
        .firstWhere((item) => item.type == value)
        .title;
  }

  String _reasonTitle(LeaveReasonEntity item) {
    final title = item.title?.trim();
    return title?.isNotEmpty == true ? title! : '---';
  }

  LeaveReasonEntity? _findReason(
    List<LeaveReasonEntity> items,
    String title,
  ) {
    for (final item in items) {
      if (_reasonTitle(item) == title) return item;
    }
    return null;
  }
}
