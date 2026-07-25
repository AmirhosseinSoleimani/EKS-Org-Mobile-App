import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_state.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/file_upload/dotted_file_picker_box.dart';
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
              builder: (context, _) {
                final hasImage = cubit.imageBase64 != null;
                return DottedFilePickerBox(
                  title: 'انتخاب تصویر',
                  description: 'فرمت‌های مجاز: PNG و JPG (حداکثر 2 مگابایت)',
                  selected: hasImage,
                  previewBytes: cubit.imageBytes,
                  isImage: true,
                  onRemove: cubit.clearImage,
                  onTap: _pickImage,
                );
              },
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
