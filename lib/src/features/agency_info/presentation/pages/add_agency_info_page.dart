import 'dart:async';
import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/add_agency_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/use_cases/add_agency_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_bottom_actions.dart';
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
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
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
  List<ProvinceEntity> _cities = const [];

  CurrentSessionEnumItemEntity? _selectedAgencyType;
  ProvinceEntity? _selectedCity;

  List<String> _cityDropDownItems = const ['انتخاب کنید'];

  bool _hasTax = false;
  bool _isSubmitting = false;
  bool _isInitialLoading = true;
  bool _isInitialLoadFailed = false;
  bool _didLoadCities = false;
  bool _didLoadEnums = false;
  bool _didShowMissingEnumsError = false;
  String? _initialLoadErrorMessage;

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
    _initializePageData();
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
        appBar: SimpleAppBar(
          title: 'افزودن نمایندگی',
          onBack: () => context.pop(false),
        ),
        bottomNavigationBar: _isFormReady
            ? AddAgencyBottomActions(
                isSubmitting: _isSubmitting,
                onCancel: () => context.pop(false),
                onSubmit: _submit,
              )
            : null,
        body: SafeArea(
          top: false,
          child: _buildBodyContent(context),
        ),
      ),
    );
  }

  bool get _isFormReady {
    return !_isInitialLoading &&
        !_isInitialLoadFailed &&
        _didLoadCities &&
        _didLoadEnums;
  }

  Widget _buildBodyContent(BuildContext context) {
    if (_isInitialLoading) {
      return Center(child: const CircularProgressIndicator());
    }

    if (_isInitialLoadFailed) {
      return AddAgencyInitialLoadError(onRetry: _initializePageData);
    }

    return Form(
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
              AddAgencyInfoSection(
                codeController: _codeController,
                nameController: _nameController,
                numberFormatters: _numberFormatters,
                requiredValidator: _requiredValidator,
                agencyTypeItems: _enumTitles(
                  _agencyTypes,
                  placeholder: 'انتخاب کنید',
                ),
                selectedAgencyTypeTitle: addAgencyEnumTitle(
                  _selectedAgencyType,
                ),
                onAgencyTypeChanged: (value) {
                  setState(() {
                    _selectedAgencyType = _enumByTitle(_agencyTypes, value);
                  });
                },
              ),
              Space.h24,
              AddAgencyManagerSection(
                managerFirstNameController: _managerFirstNameController,
                managerLastNameController: _managerLastNameController,
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
                cityItems: _cityDropDownItems,
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
    );
  }

  Future<void> _initializePageData() async {
    setState(() {
      _isInitialLoading = true;
      _isInitialLoadFailed = false;
      _didLoadCities = false;
      _didLoadEnums = false;
      _didShowMissingEnumsError = false;
      _initialLoadErrorMessage = null;
      _selectedCity = null;
      _cityDropDownItems = const ['انتخاب کنید'];
    });

    List<bool> results;
    try {
      results = await Future.wait<bool>([
        _loadSessionEnumsForInit(),
        _loadCitiesForInit(),
      ]);
    } catch (_) {
      results = const [false, false];
    }

    if (!mounted) return;

    setState(() {
      _didLoadEnums = results[0] || _agencyTypes.isNotEmpty;
      _didLoadCities = results[1] || _cities.isNotEmpty;
      _isInitialLoading = false;
      _isInitialLoadFailed = !_didLoadEnums || !_didLoadCities;
    });

    if (_isInitialLoadFailed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _showError(
          _initialLoadErrorMessage ?? 'آماده‌سازی فرم با خطا مواجه شد.',
        );
      });
    }
  }

  Future<bool> _loadSessionEnumsForInit() async {
    try {
      final hasCachedEnums = _applySessionEnums(
        _currentSessionManager.currentSession,
        notify: false,
      );

      if (hasCachedEnums) return true;

      final syncResult = await _syncCurrentSessionUseCase(
        clearOnFailure: false,
        forceRefresh: true,
        maxAge: Duration.zero,
        minRequestInterval: Duration.zero,
      );

      if (!mounted) return false;

      final hasEnums = _applySessionEnums(
        syncResult.session ?? _currentSessionManager.currentSession,
        notify: false,
      );

      if (!hasEnums) {
        _initialLoadErrorMessage ??=
            'مقادیر نوع نمایندگی از سرویس نشست دریافت نشد.';
      }

      return hasEnums;
    } catch (_) {
      _initialLoadErrorMessage ??=
          'مقادیر نوع نمایندگی از سرویس نشست دریافت نشد.';
      return false;
    }
  }

  void _onCurrentSessionChanged(CurrentSessionEntity? session) {
    if (!mounted) return;

    _applySessionEnums(session);
  }

  bool _applySessionEnums(
    CurrentSessionEntity? session, {
    bool notify = true,
  }) {
    final enums = session?.enums;
    final agencyTypes = enums?.agencyInfoType ??
        const <CurrentSessionEnumItemEntity>[];

    void applyEnums() {
      _agencyTypes = agencyTypes;
      if (_agencyTypes.isNotEmpty) {
        _didLoadEnums = true;
      }

      if (_selectedAgencyType != null &&
          !_agencyTypes.contains(_selectedAgencyType)) {
        _selectedAgencyType = null;
      }
    }

    if (mounted && notify) {
      setState(applyEnums);
    } else {
      applyEnums();
    }

    return agencyTypes.isNotEmpty;
  }

  void _showMissingSessionEnumsError() {
    if (_didShowMissingEnumsError) return;
    _didShowMissingEnumsError = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _showError('مقادیر نوع نمایندگی از سرویس نشست دریافت نشد.');
    });
  }

  Future<bool> _loadCitiesForInit() async {
    try {
      final result = await _provinceUseCase();
      if (!mounted) return false;

      var didLoad = false;

      result.when(
        success: (items, failures, resultCode) {
          _cities = items
              .where((item) => item.cityId != null)
              .toList(growable: false);
          _cityDropDownItems = _buildCityDropDownItems(_cities);
          didLoad = _cities.isNotEmpty;
          if (!didLoad) {
            _initialLoadErrorMessage ??= 'لیست شهرها دریافت نشد.';
          }
        },
        failure: (error, failures) {
          _initialLoadErrorMessage ??=
              failures ?? 'دریافت لیست شهرها با خطا مواجه شد.';
        },
        expireToken: () {
          _initialLoadErrorMessage ??= 'نشست کاربری منقضی شده است.';
        },
        connectionError: () {
          _initialLoadErrorMessage ??= 'اتصال به اینترنت برقرار نیست.';
        },
      );

      return didLoad;
    } catch (_) {
      _initialLoadErrorMessage ??= 'دریافت لیست شهرها با خطا مواجه شد.';
      return false;
    }
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

    if (_agencyTypes.isEmpty) {
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
    if (value == 'در حال دریافت...') {
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

  String get _selectedCityTitle {
    return _selectedCity == null ? 'انتخاب کنید' : _cityTitle(_selectedCity!);
  }

  List<String> _buildCityDropDownItems(List<ProvinceEntity> cities) {
    if (cities.isEmpty) return const ['انتخاب کنید'];
    return ['انتخاب کنید', ...cities.map(_cityTitle)];
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
