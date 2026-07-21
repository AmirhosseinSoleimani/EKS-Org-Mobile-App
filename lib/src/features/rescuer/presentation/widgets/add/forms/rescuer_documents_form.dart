import 'dart:typed_data';
import 'dart:ui' as BorderType;

import 'package:dotted_border/dotted_border.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_state.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class RescuerDocumentsForm extends StatelessWidget {
  const RescuerDocumentsForm({super.key, required this.cubit});

  final AddRescuerCubit cubit;

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file == null) return;
    final Uint8List bytes = await file.readAsBytes();
    cubit.setImage(bytes, file.mimeType ?? 'image/jpeg');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.documentsFormKey,
      child: RescuerFormSection(
        title: 'مدارک',
        icon: Icons.account_box_outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const BodyMediumText(
              text: 'تصویر پرسنلی',
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 8),
            BlocSelector<AddRescuerCubit, AddRescuerState, int>(
              selector: (state) => state.imageVersion,
              builder: (context, _) => _ImagePickerBox(
                selected: cubit.imageBase64 != null,
                onTap: _pickImage,
              ),
            ),
            const SizedBox(height: 18),
            DatePickerWidget(
              labelText: 'تاریخ اعتبار کارت شناسایی',
              hintText: '',
              controller: cubit.licenseCodeController,
              lastDate: Jalali(1500, 12, 29),
              onTap: cubit.setLicenseCodeDate,
              suffixIcon: const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFFA4A4A4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePickerBox extends StatelessWidget {
  const _ImagePickerBox({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(12),
          color: Color(0xFFDEC1AF),
          strokeWidth: 1,
          dashPattern: const [6, 3],

        ),

        child: Container(
          height: 170,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),

          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.upload_file_outlined,
                  color: primary,
                  size: 42,
                ),
                const SizedBox(height: 8),
                BodyMediumText(
                  text: selected ? 'تصویر انتخاب شد' : 'انتخاب تصویر',
                  color: primary,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 4),
                 BodyMediumText(
                  text: 'فرمت‌های مجاز: PNG و JPG (حداکثر 2 مگابایت)',
                  fontSize: 12,
                  color: colorScheme.onTertiaryFixed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
