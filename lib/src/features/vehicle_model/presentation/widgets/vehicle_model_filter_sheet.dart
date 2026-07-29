import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VehicleModelFilterSheet extends StatefulWidget {
  const VehicleModelFilterSheet({
    super.key,
    this.initialCode,
    this.initialName,
    this.initialIsActive,
    this.initialNavganTypeTitle,
    this.initialHasDepot,
    required this.navgans,
    required this.isNavgansLoading,
    required this.onSubmit,
  });

  final String? initialCode;
  final String? initialName;
  final bool? initialIsActive;
  final String? initialNavganTypeTitle;
  final bool? initialHasDepot;
  final List<VehicleNavganEntity> navgans;
  final bool isNavgansLoading;
  final void Function(
    String? code,
    String? name,
    bool? isActive,
    String? navganTypeTitle,
    bool? hasDepot,
  ) onSubmit;

  @override
  State<VehicleModelFilterSheet> createState() =>
      _VehicleModelFilterSheetState();
}

class _VehicleModelFilterSheetState extends State<VehicleModelFilterSheet> {
  late final TextEditingController _codeController;
  late final TextEditingController _nameController;
  VehicleNavganEntity? _selectedNavgan;
  bool? _isActive;
  bool? _hasDepot;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.initialCode);
    _nameController = TextEditingController(text: widget.initialName);
    _selectedNavgan = _initialNavgan(widget.navgans);
    _isActive = widget.initialIsActive;
    _hasDepot = widget.initialHasDepot;
  }

  @override
  void didUpdateWidget(covariant VehicleModelFilterSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedNavgan == null ||
        oldWidget.navgans.length != widget.navgans.length ||
        oldWidget.initialNavganTypeTitle != widget.initialNavganTypeTitle) {
      _selectedNavgan = _initialNavgan(widget.navgans);
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleMediumText(
                text: 'فیلتر نوع خودرو',
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
              Space.h16,
              TextFormFieldWidget(controller: _codeController, labelText: 'کد'),
              Space.h12,
              TextFormFieldWidget(controller: _nameController, labelText: 'نام'),
              Space.h12,
              OverlayDropdownFormField<VehicleNavganEntity>(
                key: ValueKey(
                  'filter-navgan-${_selectedNavgan?.id}-${widget.navgans.length}',
                ),
                labelText: 'نوع ناوگان',
                items: widget.navgans,
                value: _selectedNavgan,
                hintText: widget.isNavgansLoading
                    ? 'در حال دریافت...'
                    : 'انتخاب کنید',
                enabled: widget.navgans.isNotEmpty,
                onChanged: (item) => setState(() => _selectedNavgan = item),
              ),
              Space.h12,
              EkDropDown(
                const ['همه', 'فعال', 'غیرفعال'],
                label: 'وضعیت',
                selectedItem: _boolTitle(_isActive),
                onItemValue: (value) =>
                    setState(() => _isActive = _boolValue(value)),
              ),
              Space.h12,
              EkDropDown(
                const ['همه', 'دارد', 'ندارد'],
                label: 'مجهز به انبارک',
                selectedItem: _depotTitle(_hasDepot),
                onItemValue: (value) =>
                    setState(() => _hasDepot = _depotValue(value)),
              ),
              Space.h20,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: () {
                        widget.onSubmit(
                          _codeController.text,
                          _nameController.text,
                          _isActive,
                          _selectedNavgan?.title,
                          _hasDepot,
                        );
                        context.pop();
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'حذف فیلتر',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline,
                      titleColor: theme.colorScheme.onSurface,
                      onTap: () {
                        widget.onSubmit(null, null, null, null, null);
                        context.pop();
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

  String _boolTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return 'همه';
  }

  bool? _boolValue(String value) {
    if (value == 'فعال') return true;
    if (value == 'غیرفعال') return false;
    return null;
  }

  String _depotTitle(bool? value) {
    if (value == true) return 'دارد';
    if (value == false) return 'ندارد';
    return 'همه';
  }

  bool? _depotValue(String value) {
    if (value == 'دارد') return true;
    if (value == 'ندارد') return false;
    return null;
  }

  VehicleNavganEntity? _initialNavgan(List<VehicleNavganEntity> navgans) {
    final title = widget.initialNavganTypeTitle?.trim();
    if (title?.isNotEmpty != true) return null;
    for (final navgan in navgans) {
      if (navgan.title == title) return navgan;
    }
    return null;
  }
}
