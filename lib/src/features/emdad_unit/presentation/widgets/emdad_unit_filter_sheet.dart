import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class EmdadUnitFilterSheet extends StatefulWidget {
  const EmdadUnitFilterSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
    required this.onClear,
  });

  final EmdadUnitFilterParamEntity initialFilter;
  final ValueChanged<EmdadUnitFilterParamEntity> onApply;
  final VoidCallback onClear;

  @override
  State<EmdadUnitFilterSheet> createState() => _EmdadUnitFilterSheetState();
}

class _EmdadUnitFilterSheetState extends State<EmdadUnitFilterSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _personController;
  late final TextEditingController _agencyController;
  late final TextEditingController _vehicleController;
  late final TextEditingController _locationController;
  int? _seatType;
  int? _grade;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter;
    _nameController = TextEditingController(text: filter.name);
    _personController = TextEditingController(text: filter.personInfoFullName);
    _agencyController = TextEditingController(text: filter.agencyInfoName);
    _vehicleController = TextEditingController(text: filter.vehicleInfoTitle);
    _locationController = TextEditingController(text: filter.locationTitle);
    _seatType = filter.seatType;
    _grade = filter.grade;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p20,
          right: AppPadding.p20,
          top: AppPadding.p8,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: AppSize.s48,
                  height: AppSize.s4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
              ),
              Space.h24,
              Text(
                'جستجو و فیلتر',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Space.h24,
              _TextField(controller: _nameController, label: 'عنوان'),
              _TextField(controller: _personController, label: 'امدادرسان'),
              _TextField(controller: _agencyController, label: 'نمایندگی'),
              _TextField(controller: _vehicleController, label: 'خودرو'),
              _SelectField<int>(
                label: 'نوع مقر',
                value: _seatType,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('نوع ۱')),
                  DropdownMenuItem(value: 2, child: Text('نوع ۲')),
                ],
                onChanged: (value) => setState(() => _seatType = value),
              ),
              _TextField(controller: _locationController, label: 'محل استقرار'),
              _SelectField<int>(
                label: 'گرید',
                value: _grade,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('۱')),
                  DropdownMenuItem(value: 2, child: Text('۲')),
                  DropdownMenuItem(value: 3, child: Text('۳')),
                  DropdownMenuItem(value: 4, child: Text('۴')),
                  DropdownMenuItem(value: 5, child: Text('۵')),
                ],
                onChanged: (value) => setState(() => _grade = value),
              ),
              Space.h24,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: _apply,
                    ),
                  ),
                  Space.w16,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'پاک کردن همه',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline.withOpacity(0.65),
                      titleColor: theme.colorScheme.onSurface,
                      onTap: _clear,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _apply() {
    widget.onApply(EmdadUnitFilterParamEntity(
      name: _nameController.text,
      personInfoFullName: _personController.text,
      agencyInfoName: _agencyController.text,
      vehicleInfoTitle: _vehicleController.text,
      locationTitle: _locationController.text,
      seatType: _seatType,
      grade: _grade,
      skip: 0,
    ));
    Navigator.of(context).pop();
  }

  void _clear() {
    widget.onClear();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _personController.dispose();
    _agencyController.dispose();
    _vehicleController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p18),
      child: TextFormFieldWidget(
        controller: controller,
        textInputAction: TextInputAction.next,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        borderRadius: AppSize.s8,
      ),
    );
  }
}

class _SelectField<T> extends StatelessWidget {
  const _SelectField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final textStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurface,
    );

    final borderRadius = BorderRadius.circular(
      AppSize.s8,
    );

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.p18,
      ),
      child: SizedBox(
        height: 52,
        child: DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
          ),
          style: textStyle,
          decoration: InputDecoration(
            labelText: label,
            hintText: 'انتخاب کنید',

            floatingLabelBehavior:
            FloatingLabelBehavior.always,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),

            labelStyle: textStyle?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),

            floatingLabelStyle: textStyle?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),

            hintStyle: textStyle?.copyWith(
              color: colorScheme.onSurface.withAlpha(140),
            ),

            border: OutlineInputBorder(
              borderRadius: borderRadius,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 1.5,
              ),
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
