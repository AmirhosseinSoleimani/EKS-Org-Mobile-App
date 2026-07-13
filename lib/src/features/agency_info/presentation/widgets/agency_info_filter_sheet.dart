import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class AgencyInfoFilterSheet extends StatefulWidget {
  const AgencyInfoFilterSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
    required this.onClear,
  });

  final AgencyInfoFilterParamEntity initialFilter;
  final ValueChanged<AgencyInfoFilterParamEntity> onApply;
  final VoidCallback onClear;

  @override
  State<AgencyInfoFilterSheet> createState() => _AgencyInfoFilterSheetState();
}

class _AgencyInfoFilterSheetState extends State<AgencyInfoFilterSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _managerController;
  late final TextEditingController _cityController;
  late final TextEditingController _mobileController;
  bool? _isActive;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialFilter.name);
    _codeController = TextEditingController(text: widget.initialFilter.code);
    _managerController = TextEditingController(text: widget.initialFilter.managerFullName);
    _cityController = TextEditingController(text: widget.initialFilter.cityTitle);
    _mobileController = TextEditingController(text: widget.initialFilter.mobileNumber);
    _isActive = widget.initialFilter.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _managerController.dispose();
    _cityController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          top: AppPadding.p16,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'فیلتر نمایندگی',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              Space.h16,
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'نام نمایندگی')),
              TextField(controller: _codeController, decoration: const InputDecoration(labelText: 'کد نمایندگی')),
              TextField(controller: _managerController, decoration: const InputDecoration(labelText: 'مدیر')),
              TextField(controller: _cityController, decoration: const InputDecoration(labelText: 'شهر')),
              TextField(controller: _mobileController, decoration: const InputDecoration(labelText: 'موبایل')),
              Space.h12,
              DropdownButtonFormField<bool?>(
                value: _isActive,
                decoration: const InputDecoration(labelText: 'وضعیت'),
                items: const [
                  DropdownMenuItem<bool?>(value: null, child: Text('همه')),
                  DropdownMenuItem<bool?>(value: true, child: Text('فعال')),
                  DropdownMenuItem<bool?>(value: false, child: Text('غیرفعال')),
                ],
                onChanged: (value) => setState(() => _isActive = value),
              ),
              Space.h24,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: () {
                        widget.onApply(AgencyInfoFilterParamEntity(
                          name: _nameController.text,
                          code: _codeController.text,
                          managerFullName: _managerController.text,
                          cityTitle: _cityController.text,
                          mobileNumber: _mobileController.text,
                          isActive: _isActive,
                        ));
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'پاک کردن',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline.withOpacity(0.65),
                      titleColor: theme.colorScheme.onSurface,
                      onTap: () {
                        widget.onClear();
                        Navigator.of(context).pop();
                      },
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
}
