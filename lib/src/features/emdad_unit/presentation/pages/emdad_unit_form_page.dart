import 'dart:io';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/create_emdad_unit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_detail_row.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/view_model/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/single_location_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EmdadUnitFormPage extends StatelessWidget {
  static const path = '/emdad-unit-create-page';
  static const name = 'emdad-unit-create-page';

  const EmdadUnitFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadUnitCubit>()..loadLookups(),
      child: const _EmdadUnitFormView(),
    );
  }
}

class _EmdadUnitFormView extends StatefulWidget {
  const _EmdadUnitFormView();

  @override
  State<_EmdadUnitFormView> createState() => _EmdadUnitFormViewState();
}

class _EmdadUnitFormViewState extends State<_EmdadUnitFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  int? _agencyId;
  int? _agencyPersonId;
  int? _agencyVehicleId;
  int? _grade;
  int? _seatType;
  int? _score;
  int? _locationId;
  bool _isActive = true;
  String? _imageBase64;
  String? _imageName;
  double? _latitude;
  double? _longitude;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadUnitCubit>();
    return BlocListener<EmdadUnitCubit, EmdadUnitState>(
      listener: (context, state) {
        if (state.status == EmdadUnitViewStatus.failure && state.message != null) {
          SnakeBarWidget.showError(context: context, message: state.message!);
        }
        if (state.status == EmdadUnitViewStatus.success) {
          SnakeBarWidget.showSuccess(context: context, message: state.message ?? '');
          context.pop(true);
        }
      },
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'ثبت واحد امدادی جدید'),
        bottomNavigationBar: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: InkwellButtonWidget(
              title: 'ثبت',
              showLoading: state.status == EmdadUnitViewStatus.submitting,
              onTap: () => _submit(cubit),
            ),
          ),
        ),
        body: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
          builder: (context, state) {
            if (state.isLookupsLoading && state.agencies.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LookupField(
                      label: 'نمایندگی',
                      value: _agencyId,
                      items: state.agencies,
                      validatorText: 'انتخاب نمایندگی اجباری می باشد',
                      onChanged: (value) {
                        setState(() {
                          _agencyId = value;
                          _agencyPersonId = null;
                          _agencyVehicleId = null;
                        });
                        if (value != null) cubit.loadLookups(agencyInfoId: value);
                        _syncTitle(state);
                      },
                    ),
                    _LookupField(
                      label: 'امدادرسان',
                      value: _agencyPersonId,
                      items: state.agencyPersons,
                      validatorText: 'انتخاب امدادرسان اجباری می باشد',
                      onChanged: (value) {
                        setState(() => _agencyPersonId = value);
                        _syncTitle(state);
                      },
                    ),
                    _LookupField(
                      label: 'خودرو',
                      value: _agencyVehicleId,
                      items: state.agencyVehicles,
                      validatorText: 'انتخاب خودرو اجباری می باشد',
                      onChanged: (value) {
                        setState(() => _agencyVehicleId = value);
                        _syncTitle(state);
                      },
                    ),
                    _EnumField(
                      label: 'گرید',
                      value: _grade,
                      values: const [1, 2, 3, 4, 5],
                      validatorText: 'گرید واحد امدادی اجباری می باشد',
                      onChanged: (value) => setState(() => _grade = value),
                    ),
                    _EnumField(
                      label: 'نوع مقر',
                      value: _seatType,
                      values: const [1, 2],
                      onChanged: (value) => setState(() => _seatType = value),
                    ),
                    _LookupField(
                      label: 'محل استقرار',
                      value: _locationId,
                      items: state.locations,
                      validatorText: 'انتخاب محل استقرار اجباری می باشد',
                      onChanged: (value) {
                        final location = state.locations.firstWhereOrNull(
                          (item) => item.id == value,
                        );
                        setState(() {
                          _locationId = value;
                          _latitude = location?.latitude;
                          _longitude = location?.longitude;
                          _addressController.text = location?.address ?? '';
                        });
                        _syncTitle(state);
                      },
                    ),
                    _EnumField(
                      label: 'امتیاز',
                      value: _score,
                      values: const [1, 2, 3, 4, 5],
                      validatorText: 'انتخاب امتیاز اجباری می باشد',
                      onChanged: (value) => setState(() => _score = value),
                    ),
                    DropdownButtonFormField<bool>(
                      value: _isActive,
                      decoration: const InputDecoration(labelText: 'وضعیت'),
                      items: const [
                        DropdownMenuItem(value: true, child: BodyMediumText(text: 'فعال')),
                        DropdownMenuItem(value: false, child: BodyMediumText(text: 'غیرفعال')),
                      ],
                      onChanged: (value) => setState(() => _isActive = value ?? true),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'عنوان'),
                      validator: (value) =>
                          value?.trim().isNotEmpty == true ? null : 'عنوان اجباری می باشد',
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'آدرس محل استقرار'),
                      minLines: 2,
                      maxLines: 4,
                    ),
                    Space.h16,
                    _ImagePickerSection(
                      imageName: _imageName,
                      onPick: () => _pickImage(cubit),
                      onClear: () => setState(() {
                        _imageName = null;
                        _imageBase64 = null;
                      }),
                    ),
                    Space.h16,
                    _MapPreview(latitude: _latitude, longitude: _longitude),
                    Space.h16,
                    EmdadUnitDetailRow(label: 'عرض جغرافیایی', value: _latitude?.toString()),
                    EmdadUnitDetailRow(label: 'طول جغرافیایی', value: _longitude?.toString()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _syncTitle(EmdadUnitState state) {
    final agency = state.agencies.firstWhereOrNull((item) => item.id == _agencyId);
    final person = state.agencyPersons.firstWhereOrNull((item) => item.id == _agencyPersonId);
    final vehicle = state.agencyVehicles.firstWhereOrNull((item) => item.id == _agencyVehicleId);
    final location = state.locations.firstWhereOrNull((item) => item.id == _locationId);
    final title = [
      vehicle?.extra?['labelAgencyCode']?.toString(),
      agency?.title,
      person?.extra?['nationalNumber']?.toString(),
      person?.title,
      vehicle?.title,
      location?.title,
      'اصلی',
    ].where((item) => item != null && item.trim().isNotEmpty).join('، ');
    if (title.isNotEmpty) {
      _nameController.text = title;
    }
  }

  Future<void> _pickImage(EmdadUnitCubit cubit) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final base64 = await cubit.imageFileToBase64(File(file.path));
    if (!mounted) return;
    if (base64 == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'حجم تصویر بارگذاری شده بیشتر از 1MB می باشد.',
      );
      return;
    }
    setState(() {
      _imageBase64 = base64;
      _imageName = file.name;
    });
  }

  Future<void> _submit(EmdadUnitCubit cubit) async {
    if (!_formKey.currentState!.validate()) return;
    if (_latitude == null || _longitude == null) {
      SnakeBarWidget.showError(context: context, message: 'انتخاب محل استقرار اجباری می باشد');
      return;
    }
    await cubit.create(CreateEmdadUnitParamEntity(
      grade: _grade!,
      name: _nameController.text.trim(),
      agencyInfoId: _agencyId!,
      agencyPersonId: _agencyPersonId!,
      agencyVehicleId: _agencyVehicleId!,
      seatType: _seatType,
      score: _score!,
      imageBase64: _imageBase64,
      latitude: _latitude!,
      longitude: _longitude!,
      locationId: _locationId!,
      address: _addressController.text.trim(),
      isActive: _isActive,
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

class _LookupField extends StatelessWidget {
  const _LookupField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validatorText,
  });

  final String label;
  final int? value;
  final List<LookupEntity> items;
  final ValueChanged<int?> onChanged;
  final String? validatorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: DropdownButtonFormField<int>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: items
            .map((item) => DropdownMenuItem<int>(
                  value: item.id,
                  child: Text(item.title, overflow: TextOverflow.ellipsis),
                ))
            .toList(),
        validator: validatorText == null
            ? null
            : (value) => value == null ? validatorText : null,
        onChanged: onChanged,
      ),
    );
  }
}

class _EnumField extends StatelessWidget {
  const _EnumField({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
    this.validatorText,
  });

  final String label;
  final int? value;
  final List<int> values;
  final ValueChanged<int?> onChanged;
  final String? validatorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: DropdownButtonFormField<int>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: values
            .map((item) => DropdownMenuItem(value: item, child: Text(item.toString())))
            .toList(),
        validator: validatorText == null
            ? null
            : (value) => value == null ? validatorText : null,
        onChanged: onChanged,
      ),
    );
  }
}

class _ImagePickerSection extends StatelessWidget {
  const _ImagePickerSection({
    required this.imageName,
    required this.onPick,
    required this.onClear,
  });

  final String? imageName;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.image_rounded),
            label: Text(imageName ?? 'انتخاب تصویر'),
          ),
        ),
        if (imageName != null) ...[
          Space.w8,
          IconButton.filledTonal(
            onPressed: onClear,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ],
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview({required this.latitude, required this.longitude});

  final double? latitude;
  final double? longitude;

  @override
  Widget build(BuildContext context) {
    final lat = latitude;
    final lng = longitude;
    if (lat == null || lng == null) {
      return Container(
        height: AppSize.s180,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s8),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        child: const BodyMediumText(
          text: 'پس از انتخاب محل استقرار، موقعیت نمایش داده می‌شود',
        ),
      );
    }
    return SingleLocationMapWidget(
      latitude: lat,
      longitude: lng,
      markerStyle: const MarkerStyle(iconPath: SvgManager.location),
      serviceType: ServiceType.reliefService,
      height: AppSize.s220,
      initialZoom: 12,
    );
  }
}

extension _FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T item) test) {
    for (final item in this) {
      if (test(item)) return item;
    }
    return null;
  }
}
