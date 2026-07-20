import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_form_fields.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_form_section.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_tax_option.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAgencyInfoSection extends StatelessWidget {
  const AddAgencyInfoSection({
    super.key,
    required this.codeController,
    required this.nameController,
    required this.numberFormatters,
    required this.requiredValidator,
    required this.agencyTypeItems,
    required this.tashimTypeItems,
    required this.selectedAgencyTypeTitle,
    required this.selectedTashimTypeTitle,
    required this.onAgencyTypeChanged,
    required this.onTashimTypeChanged,
  });

  final TextEditingController codeController;
  final TextEditingController nameController;
  final List<TextInputFormatter> numberFormatters;
  final String? Function(String, String?) requiredValidator;
  final List<String> agencyTypeItems;
  final List<String> tashimTypeItems;
  final String selectedAgencyTypeTitle;
  final String selectedTashimTypeTitle;
  final ValueChanged<String> onAgencyTypeChanged;
  final ValueChanged<String> onTashimTypeChanged;

  @override
  Widget build(BuildContext context) {
    return AddAgencyFormSection(
      title: 'اطلاعات نمایندگی',
      icon: Icons.info_outline_rounded,
      children: [
        AddAgencyTextField(
          controller: codeController,
          label: 'کد نمایندگی',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: numberFormatters,
          validator: (value) => requiredValidator('کد نمایندگی', value),
        ),
        Space.h20,
        AddAgencyTextField(
          controller: nameController,
          label: 'نام نمایندگی',
          mandatory: true,
          validator: (value) => requiredValidator('نام نمایندگی', value),
        ),
        Space.h20,
        Row(
          children: [
            Expanded(
              child: AddAgencyDropDown(
                label: 'نوع',
                selectedTitle: selectedAgencyTypeTitle,
                items: agencyTypeItems,
                onChanged: onAgencyTypeChanged,
              ),
            ),
            Space.w8,
            Expanded(
              child: AddAgencyDropDown(
                label: 'نحوه تسهیم',
                selectedTitle: selectedTashimTypeTitle,
                items: tashimTypeItems,
                onChanged: onTashimTypeChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AddAgencyManagerSection extends StatelessWidget {
  const AddAgencyManagerSection({
    super.key,
    required this.managerFirstNameController,
    required this.managerLastNameController,
    required this.nationalNoController,
    required this.shabaNumberController,
    required this.numberFormatters,
    required this.requiredValidator,
  });

  final TextEditingController managerFirstNameController;
  final TextEditingController managerLastNameController;
  final TextEditingController nationalNoController;
  final TextEditingController shabaNumberController;
  final List<TextInputFormatter> numberFormatters;
  final String? Function(String, String?) requiredValidator;

  @override
  Widget build(BuildContext context) {
    return AddAgencyFormSection(
      title: 'اطلاعات مدیر',
      icon: Icons.person_outline_rounded,
      children: [
        AddAgencyTextField(
          controller: managerFirstNameController,
          label: 'نام مدیر',
        ),
        Space.h20,
        AddAgencyTextField(
          controller: managerLastNameController,
          label: 'نام خانوادگی مدیر',
        ),
        Space.h20,
        AddAgencyTextField(
          controller: nationalNoController,
          label: 'کد ملی مدیر',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: numberFormatters,
          validator: (value) => requiredValidator('کد ملی مدیر', value),
        ),
        Space.h20,
        AddAgencyTextField(
          controller: shabaNumberController,
          label: 'شماره شبا',
          hint: 'شبا IR',
          keyboardType: TextInputType.number,
          inputFormatters: numberFormatters,
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}

class AddAgencyContactSection extends StatelessWidget {
  const AddAgencyContactSection({
    super.key,
    required this.economicCodeController,
    required this.telController,
    required this.mobileController,
    required this.emailController,
    required this.faxController,
    required this.numberFormatters,
    required this.requiredValidator,
    required this.mobileValidator,
    required this.emailValidator,
  });

  final TextEditingController economicCodeController;
  final TextEditingController telController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController faxController;
  final List<TextInputFormatter> numberFormatters;
  final String? Function(String, String?) requiredValidator;
  final String? Function(String?) mobileValidator;
  final String? Function(String?) emailValidator;

  @override
  Widget build(BuildContext context) {
    return AddAgencyFormSection(
      title: 'اطلاعات تماس',
      icon: Icons.contact_phone_outlined,
      children: [
        AddAgencyTextField(
          controller: economicCodeController,
          label: 'کد اقتصادی',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: numberFormatters,
          validator: (value) => requiredValidator('کد اقتصادی', value),
        ),
        Space.h20,
        Row(
          children: [
            Expanded(
              child: AddAgencyTextField(
                controller: telController,
                label: 'تلفن',
                keyboardType: TextInputType.phone,
                inputFormatters: numberFormatters,
              ),
            ),
            Space.w8,
            Expanded(
              child: AddAgencyTextField(
                controller: mobileController,
                label: 'موبایل',
                mandatory: true,
                keyboardType: TextInputType.phone,
                inputFormatters: numberFormatters,
                validator: mobileValidator,
              ),
            ),
          ],
        ),
        Space.h20,
        AddAgencyTextField(
          controller: emailController,
          label: 'ایمیل',
          keyboardType: TextInputType.emailAddress,
          textDirection: TextDirection.ltr,
          validator: emailValidator,
        ),
        Space.h20,
        AddAgencyTextField(
          controller: faxController,
          label: 'فکس',
          keyboardType: TextInputType.phone,
          inputFormatters: numberFormatters,
        ),
      ],
    );
  }
}

class AddAgencyAddressSection extends StatelessWidget {
  const AddAgencyAddressSection({
    super.key,
    required this.addressController,
    required this.postalCodeController,
    required this.cityItems,
    required this.selectedCityTitle,
    required this.onCityChanged,
    required this.numberFormatters,
    required this.requiredValidator,
  });

  final TextEditingController addressController;
  final TextEditingController postalCodeController;
  final List<String> cityItems;
  final String selectedCityTitle;
  final ValueChanged<String> onCityChanged;
  final List<TextInputFormatter> numberFormatters;
  final String? Function(String, String?) requiredValidator;

  @override
  Widget build(BuildContext context) {
    return AddAgencyFormSection(
      title: 'آدرس',
      icon: Icons.location_on_outlined,
      children: [
        AddAgencyDropDown(
          label: 'استان و شهر',
          mandatory: true,
          selectedTitle: selectedCityTitle,
          items: cityItems,
          onChanged: onCityChanged,
        ),
        Space.h20,
        AddAgencyTextField(
          controller: addressController,
          label: 'آدرس دقیق',
          mandatory: true,
          maxLines: 4,
          keyboardType: TextInputType.streetAddress,
          validator: (value) => requiredValidator('آدرس دقیق', value),
        ),
        Space.h20,
        AddAgencyTextField(
          controller: postalCodeController,
          label: 'کدپستی',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: numberFormatters,
          validator: (value) => requiredValidator('کدپستی', value),
        ),
      ],
    );
  }
}

class AddAgencySettingsSection extends StatelessWidget {
  const AddAgencySettingsSection({
    super.key,
    required this.hasTax,
    required this.onHasTaxChanged,
  });

  final bool hasTax;
  final ValueChanged<bool> onHasTaxChanged;

  @override
  Widget build(BuildContext context) {
    return AddAgencyFormSection(
      title: 'تنظیمات',
      icon: Icons.settings_outlined,
      children: [
        AddAgencyTaxOption(
          value: hasTax,
          onChanged: onHasTaxChanged,
        ),
      ],
    );
  }
}

String addAgencyEnumTitle(CurrentSessionEnumItemEntity? item) {
  return item?.title ?? item?.name ?? item?.value?.toString() ?? 'انتخاب کنید';
}
