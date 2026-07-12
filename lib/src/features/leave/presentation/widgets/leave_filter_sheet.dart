import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_type.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
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
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8D8D8),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                Space.h24,
                Text(
                  'جستجو و فیلتر',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Space.h16,
                TextFormFieldWidget(
                  controller: cubit.agencyCodeController,
                  labelText: 'کد نمایندگی',
                  hintText: 'کد نمایندگی',
                  textInputType: TextInputType.number,
                ),
                Space.h16,
                TextFormFieldWidget(
                  controller: cubit.emdadgarNameController,
                  hintText: 'امدادرسان',
                  labelText: 'امدادرسان',
                ),
                Space.h16,
                _Dropdown<LeaveType>(
                  label: 'نوع مرخصی',
                  value: state.selectedType,
                  items: LeaveCubit.typeOptions
                      .map(
                        (item) => DropdownMenuItem(
                          value: item.type,
                          child: Text(item.title),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) cubit.onTypeChanged(value);
                  },
                ),
                Space.h16,
                _Dropdown<LeaveReasonEntity?>(
                  label: 'دلیل اصلی',
                  value: state.selectedMainReason,
                  items: [
                    const DropdownMenuItem<LeaveReasonEntity?>(
                      value: null,
                      child: Text('همه'),
                    ),
                    ...state.reasons.map(
                      (reason) => DropdownMenuItem<LeaveReasonEntity?>(
                        value: reason,
                        child: Text(reason.title ?? '---'),
                      ),
                    ),
                  ],
                  onChanged: cubit.onMainReasonChanged,
                ),
                if (state.secondaryReasons.isNotEmpty) ...[
                  Space.h16,
                  _Dropdown<LeaveReasonEntity?>(
                    label: 'دلیل فرعی',
                    value: state.selectedSecondaryReason,
                    items: [
                      const DropdownMenuItem<LeaveReasonEntity?>(
                        value: null,
                        child: Text('همه'),
                      ),
                      ...state.secondaryReasons.map(
                        (reason) => DropdownMenuItem<LeaveReasonEntity?>(
                          value: reason,
                          child: Text(reason.title ?? '---'),
                        ),
                      ),
                    ],
                    onChanged: cubit.onSecondaryReasonChanged,
                  ),
                ],
                const SizedBox(height: 20),
                InkwellButtonWidget(
                  title: 'اعمال فیلتر',
                  backgroundColor: ColorLightManager.primary,
                  onTap: () {
                    Navigator.of(context).pop();
                    cubit.applyFilters();
                  },
                ),
                const SizedBox(height: 12),
                InkwellButtonWidget(
                  title: 'پاک کردن فیلتر',
                  backgroundColor: Colors.white,
                  titleColor: const Color(0xFF555555),
                  borderColor: const Color(0xFFE0E0E0),
                  onTap: () {
                    Navigator.of(context).pop();
                    cubit.clearFilters();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      items: items,
      onChanged: onChanged,
      alignment: AlignmentDirectional.centerEnd,
      decoration: InputDecoration(
        label: Text(
            label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}

