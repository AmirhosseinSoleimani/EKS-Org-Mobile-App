import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class SearchRequestForm extends StatelessWidget {
  final TextEditingController requestNumberController;
  final TextEditingController phoneController;
  final TextEditingController chassisNumberController;
  final TextEditingController rescuerNameController;
  final TextEditingController cityController;
  final TextEditingController provinceController;

  const SearchRequestForm({
    super.key,
    required this.requestNumberController,
    required this.phoneController,
    required this.chassisNumberController,
    required this.rescuerNameController,
    required this.cityController,
    required this.provinceController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyMediumText(text: "فیلتر ها"),
        Space.h16,
        TextFormFieldWidget(
          labelText: "شماره درخواست",
          controller: requestNumberController,
          textInputType: TextInputType.number,
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: "شماره تماس",
          controller: phoneController,
          textInputType: TextInputType.phone,
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: "شماره شاسی",
          controller: chassisNumberController,
          textInputType: TextInputType.text,
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: "نام امداد رسان",
          controller: rescuerNameController,
          textInputType: TextInputType.name,
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: "شهر",
          controller: cityController,
          textInputType: TextInputType.text,
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: "استان",
          controller: provinceController,
          textInputType: TextInputType.text,
        ),
        Space.h8,
      ],
    );
  }
}
