import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
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
  State<AgencyInfoFilterSheet> createState() =>
      _AgencyInfoFilterSheetState();
}

class _AgencyInfoFilterSheetState extends State<AgencyInfoFilterSheet> {
  static const _typeTitles = <String>[
    'همه',
    'مستقل',
    'پیمانکار حمل',
    'وابسته به شبکه',
    'نمایندگی مجاز',
    'عاملیت مجاز',
  ];

  static const _booleanTitles = <String>[
    'همه',
    'تکمیل شده',
    'تکمیل نشده',
  ];

  static const _statusTitles = <String>[
    'همه',
    'فعال',
    'غیرفعال',
  ];

  late final TextEditingController _codeController;
  late final TextEditingController _nameController;
  late final TextEditingController _managerFirstNameController;
  late final TextEditingController _managerLastNameController;
  late final TextEditingController _nationalNoController;
  late final TextEditingController _economicCodeController;
  late final TextEditingController _mobileController;
  late final TextEditingController _provinceNameController;
  late final TextEditingController _cityNameController;
  late final TextEditingController _detailedCodeController;
  late final TextEditingController _agencyNationalIdController;
  late final TextEditingController _trackingNumberController;

  int? _type;
  bool? _taxFileCompleted;
  bool? _isActive;

  @override
  void initState() {
    super.initState();

    final filter = widget.initialFilter;

    _codeController = TextEditingController(
      text: filter.code,
    );

    _nameController = TextEditingController(
      text: filter.name,
    );

    _managerFirstNameController = TextEditingController(
      text: filter.managerFirstName,
    );

    _managerLastNameController = TextEditingController(
      text: filter.managerLastName,
    );

    _nationalNoController = TextEditingController(
      text: filter.nationalNo,
    );

    _economicCodeController = TextEditingController(
      text: filter.economicCode,
    );

    _mobileController = TextEditingController(
      text: filter.mobile,
    );

    _provinceNameController = TextEditingController(
      text: filter.provinceName,
    );

    _cityNameController = TextEditingController(
      text: filter.cityName,
    );

    _detailedCodeController = TextEditingController(
      text: filter.detailedCode,
    );

    _agencyNationalIdController = TextEditingController(
      text: filter.agencyNationalId,
    );

    _trackingNumberController = TextEditingController(
      text: filter.trackingNumber,
    );

    _type = filter.type;
    _taxFileCompleted = filter.taxFileCompleted;
    _isActive = filter.isActive;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _managerFirstNameController.dispose();
    _managerLastNameController.dispose();
    _nationalNoController.dispose();
    _economicCodeController.dispose();
    _mobileController.dispose();
    _provinceNameController.dispose();
    _cityNameController.dispose();
    _detailedCodeController.dispose();
    _agencyNationalIdController.dispose();
    _trackingNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final availableHeight = mediaQuery.size.height -
        mediaQuery.viewInsets.bottom -
        mediaQuery.padding.top;

    return SizedBox(
      height: availableHeight * 0.68,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p8,
            AppPadding.p8,
            AppPadding.p8,
            AppPadding.p0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(theme),
              Space.h16,

              /// فقط فیلدها اسکرول می‌شوند.
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                  ),
                  child: _buildFields(),
                ),
              ),

              _buildBottomActions(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
      ),
      child: Text(
        'فیلتر نمایندگی',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormFieldWidget(
          controller: _codeController,
          labelText: 'کد نمایندگی',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _nameController,
          labelText: 'نام نمایندگی',
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        EkDropDown(
          _typeTitles,
          label: 'نوع',
          selectedItem: _typeTitle(_type),
          onItemValue: (value) {
            setState(() {
              _type = _typeValue(value);
            });
          },
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _managerFirstNameController,
          labelText: 'نام مدیر',
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _managerLastNameController,
          labelText: 'نام خانوادگی مدیر',
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _nationalNoController,
          labelText: 'کد ملی مدیر',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _economicCodeController,
          labelText: 'کد اقتصادی',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _mobileController,
          labelText: 'شماره موبایل',
          textInputType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _provinceNameController,
          labelText: 'استان',
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _cityNameController,
          labelText: 'شهر',
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _detailedCodeController,
          labelText: 'کد تفصیلی',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _agencyNationalIdController,
          labelText: 'شناسه ملی',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: _trackingNumberController,
          labelText: 'شماره پیگیری',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
        Space.h12,
        EkDropDown(
          _booleanTitles,
          label: 'پرونده مالیاتی',
          selectedItem: _taxFileTitle(_taxFileCompleted),
          onItemValue: (value) {
            setState(() {
              _taxFileCompleted = _taxFileValue(value);
            });
          },
        ),
        Space.h12,
        EkDropDown(
          _statusTitles,
          label: 'وضعیت',
          selectedItem: _statusTitle(_isActive),
          onItemValue: (value) {
            setState(() {
              _isActive = _statusValue(value);
            });
          },
        ),
        Space.h16,
      ],
    );
  }

  Widget _buildBottomActions(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p8,
        AppPadding.p12,
        AppPadding.p8,
        AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withAlpha(25),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkwellButtonWidget(
              title: 'اعمال فیلتر',
              onTap: _apply,
            ),
          ),
          Space.w12,
          Expanded(
            child: InkwellButtonWidget(
              title: 'پاک کردن',
              backgroundColor: theme.colorScheme.onPrimary,
              borderColor: theme.colorScheme.outline.withOpacity(0.65),
              titleColor: theme.colorScheme.onSurface,
              onTap: _clear,
            ),
          ),
        ],
      ),
    );
  }

  void _apply() {
    FocusScope.of(context).unfocus();

    widget.onApply(
      AgencyInfoFilterParamEntity(
        code: _codeController.text,
        name: _nameController.text,
        type: _type,
        managerFirstName: _managerFirstNameController.text,
        managerLastName: _managerLastNameController.text,
        nationalNo: _nationalNoController.text,
        economicCode: _economicCodeController.text,
        mobile: _mobileController.text,
        provinceName: _provinceNameController.text,
        cityName: _cityNameController.text,
        detailedCode: _detailedCodeController.text,
        agencyNationalId: _agencyNationalIdController.text,
        trackingNumber: _trackingNumberController.text,
        taxFileCompleted: _taxFileCompleted,
        isActive: _isActive,
      ),
    );

    Navigator.of(context).pop();
  }

  void _clear() {
    FocusScope.of(context).unfocus();

    _codeController.clear();
    _nameController.clear();
    _managerFirstNameController.clear();
    _managerLastNameController.clear();
    _nationalNoController.clear();
    _economicCodeController.clear();
    _mobileController.clear();
    _provinceNameController.clear();
    _cityNameController.clear();
    _detailedCodeController.clear();
    _agencyNationalIdController.clear();
    _trackingNumberController.clear();

    setState(() {
      _type = null;
      _taxFileCompleted = null;
      _isActive = null;
    });

    widget.onClear();

    Navigator.of(context).pop();
  }

  String _typeTitle(int? value) {
    switch (value) {
      case 1:
        return 'مستقل';
      case 2:
        return 'پیمانکار حمل';
      case 3:
        return 'وابسته به شبکه';
      case 4:
        return 'نمایندگی مجاز';
      case 5:
        return 'عاملیت مجاز';
      default:
        return 'همه';
    }
  }

  int? _typeValue(String value) {
    switch (value) {
      case 'مستقل':
        return 1;
      case 'پیمانکار حمل':
        return 2;
      case 'وابسته به شبکه':
        return 3;
      case 'نمایندگی مجاز':
        return 4;
      case 'عاملیت مجاز':
        return 5;
      default:
        return null;
    }
  }

  String _taxFileTitle(bool? value) {
    if (value == true) {
      return 'تکمیل شده';
    }

    if (value == false) {
      return 'تکمیل نشده';
    }

    return 'همه';
  }

  bool? _taxFileValue(String value) {
    if (value == 'تکمیل شده') {
      return true;
    }

    if (value == 'تکمیل نشده') {
      return false;
    }

    return null;
  }

  String _statusTitle(bool? value) {
    if (value == true) {
      return 'فعال';
    }

    if (value == false) {
      return 'غیرفعال';
    }

    return 'همه';
  }

  bool? _statusValue(String value) {
    if (value == 'فعال') {
      return true;
    }

    if (value == 'غیرفعال') {
      return false;
    }

    return null;
  }
}