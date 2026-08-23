import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
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
    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _apply,
      onClear: _clear,
      child: _buildFields(),
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
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _nameController,
          labelText: 'نام نمایندگی',
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
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
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _managerFirstNameController,
          labelText: 'نام مدیر',
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _managerLastNameController,
          labelText: 'نام خانوادگی مدیر',
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _nationalNoController,
          labelText: 'کد ملی مدیر',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _economicCodeController,
          labelText: 'کد اقتصادی',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _mobileController,
          labelText: 'شماره موبایل',
          textInputType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _provinceNameController,
          labelText: 'استان',
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _cityNameController,
          labelText: 'شهر',
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _detailedCodeController,
          labelText: 'کد تفصیلی',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _agencyNationalIdController,
          labelText: 'شناسه ملی',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: _trackingNumberController,
          labelText: 'شماره پیگیری',
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
        FilterBottomSheetScaffold.fieldGap,
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
        FilterBottomSheetScaffold.fieldGap,
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
      ],
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