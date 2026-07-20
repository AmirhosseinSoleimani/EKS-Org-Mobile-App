import 'dart:async';
import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_info_sections.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_scaffold_widgets.dart';
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
        appBar: AddAgencyAppBar(onClose: () => context.pop(false)),
        bottomNavigationBar: AddAgencyBottomActions(
          isSubmitting: _isSubmitting,
          onCancel: () => context.pop(false),
          onSubmit: _submit,
        ),
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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p24,
                  AppPadding.p16,
                  AppPadding.p24,
                ),
                child: Column(
                  children: [
                    AddAgencyInfoSection(
                      codeController: _codeController,
                      nameController: _nameController,
                      numberFormatters: _numberFormatters,
                      requiredValidator: _requiredValidator,
                      agencyTypeItems: _enumTitles(
                        _agencyTypes,
                        placeholder: 'انتخاب کنید',
                      ),
                      tashimTypeItems: _enumTitles(
                        _tashimTypes,
                        placeholder: 'انتخاب کنید',
                      ),
                      selectedAgencyTypeTitle:
                          addAgencyEnumTitle(_selectedAgencyType),
                      selectedTashimTypeTitle:
                          addAgencyEnumTitle(_selectedTashimType),
                      onAgencyTypeChanged: (value) {
                        setState(() {
                          _selectedAgencyType =
                              _enumByTitle(_agencyTypes, value);
                        });
                      },
                      onTashimTypeChanged: (value) {
                        setState(() {
                          _selectedTashimType =
                              _enumByTitle(_tashimTypes, value);
                        });
                      },
                    ),
                    Space.h24,
                    AddAgencyManagerSection(
                      managerFirstNameController:
                          _managerFirstNameController,
                      managerLastNameController:
                          _managerLastNameController,
                      nationalNoController: _nationalNoController,
                      shabaNumberController: _shabaNumberController,
                      numberFormatters: _numberFormatters,
                      requiredValidator: _requiredValidator,
                    ),
                    Space.h24,
                    AddAgencyContactSection(
                      economicCodeController: _economicCodeController,
                      telController: _telController,
                      mobileController: _mobileController,
                      emailController: _emailController,
                      faxController: _faxController,
                      numberFormatters: _numberFormatters,
                      requiredValidator: _requiredValidator,
                      mobileValidator: _mobileValidator,
                      emailValidator: _emailValidator,
                    ),
                    Space.h24,
                    AddAgencyAddressSection(
                      addressController: _addressController,
                      postalCodeController: _postalCodeController,
                      cityItems: _cityTitles,
                      selectedCityTitle: _selectedCityTitle,
                      onCityChanged: _onCityChanged,
                      numberFormatters: _numberFormatters,
                      requiredValidator: _requiredValidator,
                    ),
                    Space.h24,
                    AddAgencySettingsSection(
                      hasTax: _hasTax,
                      onHasTaxChanged: (value) {
                        setState(() {
                          _hasTax = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadSessionEnums() async {
    final hasCachedEnums = _applySessionEnums(
      _currentSessionManager.currentSession,
    );

    if (hasCachedEnums) return;

    final syncResult = await _syncCurrentSessionUseCase(
      clearOnFailure: false,
      forceRefresh: true,
      maxAge: Duration.zero,
      minRequestInterval: Duration.zero,
    );

    if (!mounted) return;

    final hasEnums = _applySessionEnums(
      syncResult.session ?? _currentSessionManager.currentSession,
    );

    if (!hasEnums) {
      _showMissingSessionEnumsError();
    }
  }

  void _onCurrentSessionChanged(CurrentSessionEntity? session) {
    if (!mounted) return;

    _applySessionEnums(session);
  }

  bool _applySessionEnums(CurrentSessionEntity? session) {
    final enums = session?.enums;
    final agencyTypes = enums?.agencyInfoType ??
        const <CurrentSessionEnumItemEntity>[];
    final tashimTypes = enums?.agencyTashimType ??
        const <CurrentSessionEnumItemEntity>[];

    if (mounted) {
      setState(() {
        _agencyTypes = agencyTypes;
        _tashimTypes = tashimTypes;

        if (_selectedAgencyType != null &&
            !_agencyTypes.contains(_selectedAgencyType)) {
          _selectedAgencyType = null;
        }

        if (_selectedTashimType == null ||
            !_tashimTypes.contains(_selectedTashimType)) {
          _selectedTashimType = tashimTypes.isNotEmpty
              ? tashimTypes.first
              : null;
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

      _showError('مقادیر نوع نمایندگی و نحوه تسهیم از سرویس نشست دریافت نشد.');
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
    if (_isCityLoading || value == 'در حال دریافت...') {
      return;
    }

    setState(() {
      _selectedCity = value == 'انتخاب کنید' ? null : _findCityByTitle(value);
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
