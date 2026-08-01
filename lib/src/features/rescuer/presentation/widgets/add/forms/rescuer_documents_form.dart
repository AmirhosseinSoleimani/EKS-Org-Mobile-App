import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_section.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/upload_file.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class RescuerDocumentsForm extends StatelessWidget {
  const RescuerDocumentsForm({super.key, required this.cubit});

  final AddRescuerCubit cubit;

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
            UploadFileField(
              type: UploadFileType.image,
              title: 'انتخاب تصویر',
              onChanged: cubit.setProfileImage,
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
