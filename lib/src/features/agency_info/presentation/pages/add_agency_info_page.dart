import 'dart:async';
import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_form_section.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_tax_option.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_province_with_city_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/use_cases/sync_current_session_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AddAgencyInfoPage extends StatefulWidget {
  static const path = '/add-agency-info-page';
  static const name = 'add-agency-info-page';

  const AddAgencyInfoPage({super.key});

  @override
  State<AddAgencyInfoPage> createState() => _AddAgencyInfoPageState();
}

class _AddAgencyInfoPageState extends State<AddAgencyInfoPage> {
  final _formKey = GlobalKey<FormState>();

  late final AddAgencyInfoUseCase _addAgencyUseCase;
  late final GetProvinceWithCityListUseCase _provinceUseCase;
  late final CurrentSessionManager _currentSessionManager;
  late final SyncCurrentSessionUseCase _syncCurrentSessionUseCase;
  StreamSubscription<CurrentSessionEntity?>? _sessionSubscription;

  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _managerFirstNameController = TextEditingController();
  final _managerLastNameController = TextEditingController();
  final _nationalNoController = TextEditingController();
  final _shabaNumberController = TextEditingController();
  final _economicCodeController = TextEditingController();
  final _telController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _faxController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();

  List<CurrentSessionEnumItemEntity> _agencyTypes = const [];
  List<CurrentSessionEnumItemEntity> _tashimTypes = const [];
  List<ProvinceEntity> _cities = const [];

  CurrentSessionEnumItemEntity? _selectedAgencyType;
  CurrentSessionEnumItemEntity? _selectedTashimType;
  ProvinceEntity? _selectedCity;

  bool _hasTax = false;
  bool _isSubmitting = false;
  bool _isCityLoading = false;
  bool _isSessionEnumsLoading = true;
  bool _didShowMissingEnumsError = false;

  @override
  void initState() {
    super.initState();
    _addAgencyUseCase = AddAgencyInfoUseCase(getIt<AgencyInfoRepository>());
    _provinceUseCase = getIt<GetProvinceWithCityListUseCase>();
    _currentSessionManager = getIt<CurrentSessionManager>();
    _syncCurrentSessionUseCase = getIt<SyncCurrentSessionUseCase>();
    _sessionSubscription = _currentSessionManager.currentSessionStream.listen(
      _onCurrentSessionChanged,
    );
    _loadSessionEnums();
    _loadCities();
  }

  @override
  void dispose() {
    _sessionSubscription?.cancel();
    _codeController.dispose();
    _nameController.dispose();
    _managerFirstNameController.dispose();
    _managerLastNameController.dispose();
    _nationalNoController.dispose();
    _shabaNumberController.dispose();
    _economicCodeController.dispose();
    _telController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _faxController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: _AddAgencyAppBar(onClose: () => context.pop(false)),
        bottomNavigationBar: _buildBottomActions(theme),
        body: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p24,
                AppPadding.p16,
                AppPadding.p24,
              ),
              child: Column(
                children: [
                  _buildAgencyInfoSection(),
                  Space.h24,
                  _buildManagerInfoSection(),
                  Space.h24,
                  _buildContactInfoSection(),
                  Space.h24,
                  _buildAddressSection(),
                  Space.h24,
                  _buildSettingsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildAgencyInfoSection() {
    return AddAgencyFormSection(
      title: 'اطلاعات نمایندگی',
      icon: Icons.info_outline_rounded,
      children: [
        _textField(
          controller: _codeController,
          label: 'کد نمایندگی',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: _numberFormatters,
        ),
        Space.h20,
        _textField(
          controller: _nameController,
          label: 'نام نمایندگی',
          mandatory: true,
        ),
        Space.h20,
        Row(
          children: [
            Expanded(
              child: _dropDown(
                label: 'نوع',
                placeholder: 'انتخاب کنید',
                selectedTitle:
                _selectedAgencyType?.title ?? 'انتخاب کنید',
                items: _enumTitles(
                  _agencyTypes,
                  placeholder: 'انتخاب کنید',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedAgencyType = _enumByTitle(_agencyTypes, value);
                  });
                },
              ),
            ),
            Space.w8,
            Expanded(
              child: _dropDown(
                label: 'نحوه تسهیم',
                placeholder: 'انتخاب کنید',
                selectedTitle:
                _selectedTashimType?.title ?? 'انتخاب کنید',
                items: _enumTitles(
                  _tashimTypes,
                  placeholder: 'انتخاب کنید',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedTashimType = _enumByTitle(_tashimTypes, value);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildManagerInfoSection() {
    return AddAgencyFormSection(
      title: 'اطلاعات مدیر',
      icon: Icons.person_outline_rounded,
      children: [
        _textField(
          controller: _managerFirstNameController,
          label: 'نام مدیر',
        ),
        Space.h20,
        _textField(
          controller: _managerLastNameController,
          label: 'نام خانوادگی مدیر',
        ),
        Space.h20,
        _textField(
          controller: _nationalNoController,
          label: 'کد ملی مدیر',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: _numberFormatters,
        ),
        Space.h20,
        _textField(
          controller: _shabaNumberController,
          label: 'شماره شبا',
          hint: 'شبا IR',
          keyboardType: TextInputType.number,
          inputFormatters: _numberFormatters,
          textDirection: TextDirection.ltr
        ),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return AddAgencyFormSection(
      title: 'اطلاعات تماس',
      icon: Icons.contact_phone_outlined,
      children: [
        _textField(
          controller: _economicCodeController,
          label: 'کد اقتصادی',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: _numberFormatters,
        ),
        Space.h20,
        Row(
          children: [
            Expanded(
              child: _textField(
                controller: _telController,
                label: 'تلفن',
                keyboardType: TextInputType.phone,
                inputFormatters: _numberFormatters,
              ),
            ),
            Space.w8,
            Expanded(
              child: _textField(
                controller: _mobileController,
                label: 'موبایل',
                mandatory: true,
                keyboardType: TextInputType.phone,
                inputFormatters: _numberFormatters,
                validator: _mobileValidator,
              ),
            ),
          ],
        ),
        Space.h20,
        _textField(
          controller: _emailController,
          label: 'ایمیل',
          keyboardType: TextInputType.emailAddress,
          textDirection: TextDirection.ltr,
          validator: _emailValidator,
        ),
        Space.h20,
        _textField(
          controller: _faxController,
          label: 'فکس',
          keyboardType: TextInputType.phone,
          inputFormatters: _numberFormatters,
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return AddAgencyFormSection(
      title: 'آدرس',
      icon: Icons.location_on_outlined,
      children: [
        _dropDown(
          label: 'استان و شهر',
          mandatory: true,
          selectedTitle: _selectedCityTitle,
          items: _cityTitles,
          onChanged: _onCityChanged,
        ),
        Space.h20,
        _textField(
          controller: _addressController,
          label: 'آدرس دقیق',
          mandatory: true,
          maxLines: 4,
          keyboardType: TextInputType.streetAddress,
        ),
        Space.h20,
        _textField(
          controller: _postalCodeController,
          label: 'کدپستی',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: _numberFormatters,
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return AddAgencyFormSection(
      title: 'تنظیمات',
      icon: Icons.settings_outlined,
      children: [
        AddAgencyTaxOption(
          value: _hasTax,
          onChanged: (value) {
            setState(() {
              _hasTax = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBottomActions(ThemeData theme) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p8,
          AppPadding.p16,
          AppPadding.p12,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextButton(
                onPressed: _isSubmitting ? null : () => context.pop(false),
                child: Text(
                  'انصراف',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryFixed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Space.w12,
            Expanded(
              flex: 5,
              child: InkwellButtonWidget(
                title: 'افزودن',
                showLoading: _isSubmitting,
                onTap: _submit,
                backgroundColor: theme.colorScheme.primary,
                borderRadius: AppSize.s8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
     String? hint,
    bool mandatory = false,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines,
    Widget? prefixIcon,
    TextDirection? textDirection,
    String? Function(String?)? validator,
  }) {
    return TextFormFieldWidget(
      controller: controller,
      labelText: label,
      hintText: hint,
      mandatory: mandatory,
      textInputType: keyboardType,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      textInputFormatter: inputFormatters,
      maxLines: maxLines,
      prefixIcon: prefixIcon,
      textDirection: textDirection,
      textInputAction: maxLines == null || maxLines == 1
          ? TextInputAction.next
          : TextInputAction.newline,
      validator: validator ??
          (mandatory ? (value) => _requiredValidator(label, value) : null),
    );
  }

  Widget _dropDown({
    required String label,
    required List<String> items,
    required ValueChanged<String> onChanged,
    String? selectedTitle,
    String placeholder = 'انتخاب کنید',
    bool mandatory = false,
  }) {
    final safeItems = items.isEmpty ? [placeholder] : items;
    return EkDropDown(
      safeItems,
      label: label,
      mandatory: mandatory,
      selectedItem: selectedTitle ?? safeItems.first,
      onItemValue: onChanged,
    );
  }

  Future<void> _loadSessionEnums() async {
    final hasCachedEnums = _applySessionEnums(
      _currentSessionManager.currentSession,
      isLoading: false,
    );

    if (hasCachedEnums) return;

    if (mounted) {
      setState(() {
        _isSessionEnumsLoading = true;
      });
    }

    final syncResult = await _syncCurrentSessionUseCase(
      clearOnFailure: false,
      forceRefresh: true,
      maxAge: Duration.zero,
      minRequestInterval: Duration.zero,
    );

    if (!mounted) return;

    final hasEnums = _applySessionEnums(
      syncResult.session ?? _currentSessionManager.currentSession,
      isLoading: false,
    );

    if (!hasEnums) {
      _showMissingSessionEnumsError();
    }
  }

  void _onCurrentSessionChanged(CurrentSessionEntity? session) {
    if (!mounted) return;

    _applySessionEnums(
      session,
      isLoading: false,
    );
  }

  bool _applySessionEnums(CurrentSessionEntity? session, {
    required bool isLoading,
  }) {
    final enums = session?.enums;
    final agencyTypes = enums?.agencyInfoType ??
        const <CurrentSessionEnumItemEntity>[];
    final tashimTypes = enums?.agencyTashimType ??
        const <CurrentSessionEnumItemEntity>[];

    if (mounted) {
      setState(() {
        _agencyTypes = agencyTypes;
        _tashimTypes = tashimTypes;
        _isSessionEnumsLoading = isLoading;

        if (_selectedAgencyType != null &&
            !_agencyTypes.contains(_selectedAgencyType)) {
          _selectedAgencyType = null;
        }

        if (_selectedTashimType == null ||
            !_tashimTypes.contains(_selectedTashimType)) {
          _selectedTashimType =
          tashimTypes.isNotEmpty ? tashimTypes.first : null;
        }
      });
    }

    return agencyTypes.isNotEmpty && tashimTypes.isNotEmpty;
  }

  void _showMissingSessionEnumsError() {
    if (_didShowMissingEnumsError) return;
    _didShowMissingEnumsError = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _showError(
          'مقادیر نوع نمایندگی و نحوه تسهیم از سرویس نشست دریافت نشد. '
      );
    });
  }

  Future<void> _loadCities() async {
    setState(() {
      _isCityLoading = true;
    });

    final result = await _provinceUseCase();
    if (!mounted) return;

    result.when(
      success: (items, failures, resultCode) {
        setState(() {
          _cities = items
              .where((item) => item.cityId != null)
              .toList(growable: false);
          _isCityLoading = false;
        });
      },
      failure: (error, failures) {
        setState(() {
          _isCityLoading = false;
        });
        _showError(failures ?? 'دریافت لیست شهرها با خطا مواجه شد.');
      },
      expireToken: () {
        setState(() {
          _isCityLoading = false;
        });
        _showError('نشست کاربری منقضی شده است.');
      },
      connectionError: () {
        setState(() {
          _isCityLoading = false;
        });
        _showError('اتصال به اینترنت برقرار نیست.');
      },
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      _showError('لطفا فیلدهای اجباری را تکمیل کنید.');
      return;
    }

    if (_selectedCity?.cityId == null) {
      _showError('استان و شهر را انتخاب کنید.');
      return;
    }

    if (_agencyTypes.isEmpty || _tashimTypes.isEmpty) {
      _showMissingSessionEnumsError();
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final result = await _addAgencyUseCase(
      AddAgencyInfoParamEntity(
        code: _trim(_codeController),
        name: _trim(_nameController),
        type: _selectedAgencyType?.value,
        managerFirstName: _optional(_managerFirstNameController),
        managerLastName: _optional(_managerLastNameController),
        nationalNo: _trim(_nationalNoController),
        economicCode: _trim(_economicCodeController),
        tel: _optional(_telController),
        mobile: _trim(_mobileController),
        fax: _optional(_faxController),
        email: _optional(_emailController),
        hasTax: _hasTax,
        cityId: _selectedCity!.cityId!,
        postalCode: _trim(_postalCodeController),
        tashimType: _selectedTashimType?.value,
        shabaNumber: _optional(_shabaNumberController),
        address: _trim(_addressController),
      ),
    );

    if (!mounted) return;

    result.when(
      success: (data, failures, resultCode) {
        context.pop(true);
      },
      failure: (error, failures) {
        setState(() {
          _isSubmitting = false;
        });
        _showError(failures ?? 'ثبت نمایندگی با خطا مواجه شد.');
      },
      expireToken: () {
        setState(() {
          _isSubmitting = false;
        });
        _showError('نشست کاربری منقضی شده است.');
      },
      connectionError: () {
        setState(() {
          _isSubmitting = false;
        });
        _showError('اتصال به اینترنت برقرار نیست.');
      },
    );
  }

  void _onCityChanged(String value) {
    if (_isCityLoading || value == 'انتخاب کنید') {
      return;
    }

    setState(() {
      _selectedCity = _findCityByTitle(value);
    });
  }

  String? _requiredValidator(String label, String? value) {
    if (value == null || value.trim().isEmpty) {
      return '$label را وارد کنید';
    }
    return null;
  }

  String? _mobileValidator(String? value) {
    final requiredError = _requiredValidator('موبایل', value);
    if (requiredError != null) return requiredError;

    if (!RegExp(r'^09\d{9}$').hasMatch(value!.trim())) {
      return 'شماره موبایل معتبر نیست.';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return null;

    final emailRegex = RegExp(r'^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'ایمیل وارد شده معتبر نیست.';
    }
    return null;
  }

  void _showError(String message) {
    BottomSheetMessage.showError(
      context: context,
      data: BottomSheetMessageModel(
        title: 'خطا',
        message: message.trim().isEmpty ? 'عملیات با خطا مواجه شد.' : message,
      ),
      onButtonTap: () => context.pop(),
    );
  }

  List<String> _enumTitles(
    List<CurrentSessionEnumItemEntity> items, {
    String? placeholder,
  }) {
    final titles = items
        .map((item) => item.title ?? item.name ?? item.value?.toString() ?? '')
        .where((title) => title.trim().isNotEmpty)
        .toList();

    if (placeholder != null) {
      return [placeholder, ...titles];
    }

    return titles.isEmpty ? ['انتخاب کنید'] : titles;
  }

  CurrentSessionEnumItemEntity? _enumByTitle(
    List<CurrentSessionEnumItemEntity> items,
    String title,
  ) {
    if (title == 'انتخاب کنید' || title == 'در حال دریافت...') {
      return null;
    }

    for (final item in items) {
      final itemTitle = item.title ?? item.name ?? item.value?.toString() ?? '';
      if (itemTitle == title) return item;
    }
    return null;
  }

  List<String> get _cityTitles {
    if (_isCityLoading) return const ['در حال دریافت...'];
    if (_cities.isEmpty) return const ['انتخاب کنید'];
    return ['انتخاب کنید', ..._cities.map(_cityTitle)];
  }

  String get _selectedCityTitle {
    if (_isCityLoading) return 'در حال دریافت...';
    return _selectedCity == null ? 'انتخاب کنید' : _cityTitle(_selectedCity!);
  }

  String _cityTitle(ProvinceEntity city) {
    final province = city.title?.trim() ?? '';
    final cityName = city.cityName?.trim() ?? '';
    if (province.isNotEmpty && cityName.isNotEmpty) {
      return '$province - $cityName';
    }
    return cityName.isNotEmpty ? cityName : province;
  }

  ProvinceEntity? _findCityByTitle(String title) {
    for (final city in _cities) {
      if (_cityTitle(city) == title) return city;
    }
    return null;
  }

  String _trim(TextEditingController controller) => controller.text.trim();

  String? _optional(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  List<TextInputFormatter> get _numberFormatters {
    return [
      PersianArabicDigitsToEnglishFormatter(),
      FilteringTextInputFormatter.digitsOnly,
    ];
  }
}

class _AddAgencyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AddAgencyAppBar({
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: theme.colorScheme.onPrimary,
      titleSpacing: 0,
      title: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            IconButton(
              onPressed: onClose,
              icon: Icon(
                Icons.close_rounded,
                color: theme.colorScheme.onPrimaryFixedVariant,
              ),
            ),
            Expanded(
              child: Text(
                'افزودن نمایندگی',
                textAlign: TextAlign.right,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Space.w16,
          ],
        ),
      ),
    );
  }
}
