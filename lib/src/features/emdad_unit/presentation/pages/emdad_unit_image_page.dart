import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/update_emdad_unit_image_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EmdadUnitImagePage extends StatelessWidget {
  static const path = '/emdad-unit-image-page';
  static const name = 'emdad-unit-image-page';

  const EmdadUnitImagePage({super.key, required this.item});

  final EmdadUnitEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadUnitCubit>(),
      child: _EmdadUnitImageView(item: item),
    );
  }
}

class _EmdadUnitImageView extends StatefulWidget {
  const _EmdadUnitImageView({required this.item});

  final EmdadUnitEntity item;

  @override
  State<_EmdadUnitImageView> createState() => _EmdadUnitImageViewState();
}

class _EmdadUnitImageViewState extends State<_EmdadUnitImageView> {
  String? _imageBase64;
  String? _imageName;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _imageBase64 = widget.item.imageBase64;
    _imageName = widget.item.imageBase64?.trim().isNotEmpty == true ? 'current-image' : null;
    _isActive = widget.item.isActive ?? true;
  }

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
        appBar: const SimpleAppBar(title: 'ویرایش تصویر واحد امدادی'),
        bottomNavigationBar: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: InkwellButtonWidget(
              title: 'ثبت تغییرات',
              showLoading: state.status == EmdadUnitViewStatus.submitting,
              onTap: () => _submit(cubit),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppPadding.p16),
          children: [
            Text(widget.item.name ?? '', style: Theme.of(context).textTheme.titleMedium),
            Space.h16,
            _ImagePreview(imageBase64: _imageBase64),
            Space.h16,
            OutlinedButton.icon(
              onPressed: () => _pickImage(cubit),
              icon: const Icon(Icons.image_rounded),
              label: Text(_imageName ?? 'انتخاب تصویر'),
            ),
            if (_imageName != null) ...[
              Space.h8,
              OutlinedButton.icon(
                onPressed: () => setState(() {
                  _imageBase64 = '';
                  _imageName = null;
                }),
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('حذف تصویر انتخاب‌شده'),
              ),
            ],
            Space.h16,
            SwitchListTile(
              value: _isActive,
              title: const Text('وضعیت فعال'),
              onChanged: (value) => setState(() => _isActive = value),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(EmdadUnitCubit cubit) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final imageBase64 = await cubit.imageFileToBase64(File(file.path));
    if (!mounted) return;
    if (imageBase64 == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'حجم تصویر بارگذاری شده بیشتر از 1MB می باشد.',
      );
      return;
    }
    setState(() {
      _imageBase64 = imageBase64;
      _imageName = file.name;
    });
  }

  void _submit(EmdadUnitCubit cubit) {
    final id = widget.item.id;
    if (id == null) {
      SnakeBarWidget.showError(context: context, message: 'شناسه واحد امدادی نامعتبر است.');
      return;
    }
    cubit.updateImage(UpdateEmdadUnitImageParamEntity(
      emdadUnitId: id,
      imageBase64: _imageBase64 ?? '',
      isActive: _isActive,
    ));
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.imageBase64});

  final String? imageBase64;

  @override
  Widget build(BuildContext context) {
    final bytes = _decodeImage(imageBase64);
    return Container(
      height: AppSize.s220,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      clipBehavior: Clip.antiAlias,
      child: bytes == null
          ? const Icon(Icons.car_repair_rounded, size: AppSize.s64)
          : Image.memory(bytes, fit: BoxFit.cover, width: double.infinity),
    );
  }

  Uint8List? _decodeImage(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    try {
      final uriData = Uri.tryParse(value)?.data;
      if (uriData != null) {
        return uriData.contentAsBytes();
      }
      return base64Decode(value);
    } catch (_) {
      return null;
    }
  }
}
