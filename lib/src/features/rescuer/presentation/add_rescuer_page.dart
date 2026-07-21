import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_state.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_dropdown_field.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_actions.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_section.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_stepper.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_full_screen_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddRescuerResult {
  final int rescuerId;
  final bool viewProfile;

  const AddRescuerResult({required this.rescuerId, this.viewProfile = false});
}

class AddRescuerPage extends StatelessWidget {
  const AddRescuerPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<AddRescuerCubit>()..init(),
    child: const _AddRescuerView(),
  );
}

class _AddRescuerView extends StatelessWidget {
  const _AddRescuerView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddRescuerCubit>();
    return BlocConsumer<AddRescuerCubit, AddRescuerState>(
      listenWhen: (p, c) =>
          p.errorMessage != c.errorMessage ||
          p.connectionError != c.connectionError,
      listener: (context, state) {
        if (state.errorMessage != null) {
          BottomSheetMessage.showError(
            context: context,
            data: BottomSheetMessageModel(
              title: 'خطا',
              message: state.errorMessage!,
            ),
          );
        } else if (state.connectionError) {
          BottomSheetMessage.showCustom(
            context: context,
            content: NoInternetBottomSheet(onRetry: cubit.init),
            actionWidget: const SizedBox.shrink(),
            isDismissible: false,
            enableDrag: false,
          );
        }
      },
      builder: (context, state) {
        if (state.createdId != null) {
          return _SuccessView(id: int.tryParse(state.createdId!) ?? 0);
        }
        return Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          appBar: const RescuerFullScreenSheetAppBar(title: 'افزودن امدادرسان'),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: RescuerStepper(current: state.currentStep),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: IndexedStack(
                    index: state.currentStep,
                    children: [
                      _IdentityForm(cubit),
                      _ContactForm(cubit),
                      _CooperationForm(cubit),
                      _DocumentsForm(cubit),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: RescuerFormActions(
            step: state.currentStep,
            loading: state.isLoading,
            onNext: state.currentStep == 3 ? cubit.submit : cubit.next,
            onPrevious: state.currentStep == 0
                ? () => Navigator.of(context).pop()
                : cubit.previous,
          ),
        );
      },
    );
  }
}

String? _required(String? value, String title) =>
    value == null || value.trim().isEmpty ? '$title الزامی است' : null;

class _IdentityForm extends StatelessWidget {
  final AddRescuerCubit c;

  const _IdentityForm(this.c);

  @override
  Widget build(BuildContext context) => Form(
    key: c.identityFormKey,
    child: RescuerFormSection(
      title: 'اطلاعات هویتی',
      icon: Icons.badge_outlined,
      child: Column(
        children: [
          TextFormFieldWidget(
            labelText: 'نام',
            mandatory: true,
            controller: c.firstNameController,
            validator: (v) => _required(v, 'نام'),
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'نام خانوادگی',
            mandatory: true,
            controller: c.lastNameController,
            validator: (v) => _required(v, 'نام خانوادگی'),
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'نام پدر',
            controller: c.fatherNameController,
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'کدملی',
            mandatory: true,
            controller: c.nationalNumberController,
            textInputType: TextInputType.number,
            maxLength: 10,
            validator: (v) => _required(v, 'کدملی'),
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'تاریخ تولد',
            mandatory: true,
            controller: c.birthDateController,
            hintText: '2026-07-05T20:30:00.000Z',
            validator: (v) => _required(v, 'تاریخ تولد'),
            suffixIcon: const Icon(Icons.calendar_month_outlined),
          ),
          const SizedBox(height: 16),
          _CityDropdown(
            label: 'محل تولد',
            value: c.birthCityId,
            cities: c.cities,
            onChanged: (v) => c.birthCityId = v,
          ),
        ],
      ),
    ),
  );
}

class _ContactForm extends StatelessWidget {
  final AddRescuerCubit c;

  const _ContactForm(this.c);

  @override
  Widget build(BuildContext context) => Form(
    key: c.contactFormKey,
    child: RescuerFormSection(
      title: 'اطلاعات تماس و محل',
      icon: Icons.contact_phone_outlined,
      child: Column(
        children: [
          TextFormFieldWidget(
            labelText: 'موبایل',
            mandatory: true,
            controller: c.mobileController,
            textInputType: TextInputType.phone,
            maxLength: 11,
            validator: (v) => _required(v, 'موبایل'),
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'تلفن',
            controller: c.telController,
            textInputType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          _CityDropdown(
            label: 'محل صدور شناسنامه',
            value: c.issuingCityId,
            cities: c.cities,
            onChanged: (v) => c.issuingCityId = v,
            mandatory: true,
          ),
          const SizedBox(height: 16),
          _CityDropdown(
            label: 'شهر محل سکونت',
            value: c.addressCityId,
            cities: c.cities,
            onChanged: (v) => c.addressCityId = v,
            mandatory: true,
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'آدرس',
            mandatory: true,
            controller: c.addressController,
            maxLines: 4,
            validator: (v) => _required(v, 'آدرس'),
          ),
        ],
      ),
    ),
  );
}

class _CooperationForm extends StatelessWidget {
  final AddRescuerCubit c;

  const _CooperationForm(this.c);

  @override
  Widget build(BuildContext context) => Form(
    key: c.cooperationFormKey,
    child: RescuerFormSection(
      title: 'اطلاعات همکاری',
      icon: Icons.person_outline,
      child: Column(
        children: [
          RescuerDropdownField<int>(
            label: 'وضعیت تأهل',
            mandatory: true,
            value: c.marital,
            items: [
              RescuerDropdownField.item(1, 'مجرد'),
              RescuerDropdownField.item(2, 'متأهل'),
            ],
            onChanged: (v) => c.marital = v,
          ),
          const SizedBox(height: 16),
          RescuerDropdownField<int>(
            label: 'مدرک تحصیلی',
            value: c.degree,
            items: [
              RescuerDropdownField.item(1, 'زیر دیپلم'),
              RescuerDropdownField.item(2, 'دیپلم'),
              RescuerDropdownField.item(3, 'کاردانی'),
              RescuerDropdownField.item(4, 'کارشناسی'),
              RescuerDropdownField.item(5, 'کارشناسی ارشد'),
              RescuerDropdownField.item(6, 'دکتری'),
            ],
            onChanged: (v) => c.degree = v,
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'رشته',
            controller: c.fieldGraduationController,
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'سایز لباس',
            controller: c.clothingSizeController,
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'سایز کفش',
            controller: c.shoesSizeController,
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: 'تاریخ شروع همکاری',
            mandatory: true,
            controller: c.cooperationStartDateController,
            hintText: '2026-07-13',
            validator: (v) => _required(v, 'تاریخ شروع همکاری'),
            suffixIcon: const Icon(Icons.calendar_month_outlined),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const BodyMediumText(text: 'وضعیت فعال'),
            value: c.isActive,
            onChanged: (v) {
              c.isActive = v;
              c.setStep(c.state.currentStep);
            },
          ),
        ],
      ),
    ),
  );
}

class _DocumentsForm extends StatelessWidget {
  final AddRescuerCubit c;

  const _DocumentsForm(this.c);

  Future<void> _pick() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file == null) return;
    final Uint8List bytes = await file.readAsBytes();
    c.setImage(bytes, file.mimeType ?? 'image/jpeg');
  }

  @override
  Widget build(BuildContext context) => Form(
    key: c.documentsFormKey,
    child: RescuerFormSection(
      title: 'مدارک',
      icon: Icons.account_box_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BodyMediumText(
            text: 'تصویر پرسنلی',
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: _pick,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withAlpha(120),
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      c.imageBase64 == null
                          ? Icons.upload_file_outlined
                          : Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 42,
                    ),
                    const SizedBox(height: 8),
                    BodyMediumText(
                      text: c.imageBase64 == null
                          ? 'انتخاب تصویر'
                          : 'تصویر انتخاب شد',
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 4),
                    const BodyMediumText(
                      text: 'فرمت‌های مجاز: PNG و JPG',
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          TextFormFieldWidget(
            labelText: 'تاریخ اعتبار کارت شناسایی',
            controller: c.licenseCodeController,
            hintText: '2026-06-28T20:30:00.000Z',
            suffixIcon: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
    ),
  );
}

class _CityDropdown extends StatelessWidget {
  final String label;
  final int? value;
  final List<ProvinceEntity> cities;
  final ValueChanged<int?> onChanged;
  final bool mandatory;

  const _CityDropdown({
    required this.label,
    required this.value,
    required this.cities,
    required this.onChanged,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) => RescuerDropdownField<int>(
    label: label,
    value: value,
    mandatory: mandatory,
    items: cities
        .map(
          (e) => RescuerDropdownField.item(
            e.cityId!,
            e.cityName ?? e.title ?? '-',
          ),
        )
        .toList(),
    onChanged: onChanged,
  );
}

class _SuccessView extends StatelessWidget {
  final int id;

  const _SuccessView({required this.id});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F4F4),
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE3F1E5),
                        border: Border.all(
                          color: const Color(0xFFD1E7D5),
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Color(0xFF18752A),
                        size: 70,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const TitleLargeText(
                      text: 'افزودن با موفقیت انجام شد',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const BodyMediumText(
                      text: 'اطلاعات امدادرسان جدید در سیستم ثبت گردید.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(AddRescuerResult(rescuerId: id)),
                    icon: const Icon(Icons.list),
                    label: const BodyMediumText(
                      text: 'بازگشت به لیست',
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(AddRescuerResult(rescuerId: id, viewProfile: true)),
                    icon: const Icon(Icons.account_circle_outlined),
                    label: const BodyMediumText(text: 'مشاهده پروفایل'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
