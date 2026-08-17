import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchRequestForm extends StatelessWidget {
  final TextEditingController requestNumberController;
  final TextEditingController phoneController;
  final TextEditingController chassisNumberController;
  final TextEditingController rescuerNameController;
  final TextEditingController cityController;
  final TextEditingController provinceController;
  final ServiceType serviceType;

  const SearchRequestForm({
    super.key,
    required this.requestNumberController,
    required this.phoneController,
    required this.chassisNumberController,
    required this.rescuerNameController,
    required this.cityController,
    required this.provinceController,
    required this.serviceType,
  });

  bool get _isHomeService => serviceType == ServiceType.homeService;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyMediumText(text: 'فیلتر ها'),
        Space.h16,
        TextFormFieldWidget(
          labelText: 'شماره درخواست',
          controller: requestNumberController,
          textInputType: TextInputType.number,
          maxLength: 9,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          textInputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(9),
          ],
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: 'شماره تماس',
          controller: phoneController,
          textInputType:
              _isHomeService ? TextInputType.number : TextInputType.text,
          maxLength: 13,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          textInputFormatter: [
            if (_isHomeService) FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(13),
          ],
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: 'شماره شاسی',
          controller: chassisNumberController,
          textInputType: TextInputType.text,
          maxLength: 17,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          textInputFormatter: [
            LengthLimitingTextInputFormatter(17),
          ],
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: _isHomeService ? 'نام خدمت رسان' : 'نام امداد رسان',
          controller: rescuerNameController,
          textInputType: TextInputType.text,
          maxLength: 40,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          textInputFormatter: [
            LengthLimitingTextInputFormatter(40),
          ],
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: 'شهر',
          controller: cityController,
          textInputType: TextInputType.text,
          maxLength: 20,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          textInputFormatter: [
            LengthLimitingTextInputFormatter(20),
          ],
        ),
        Space.h8,
        TextFormFieldWidget(
          labelText: 'استان',
          controller: provinceController,
          textInputType: TextInputType.text,
          maxLength: 20,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          textInputFormatter: [
            LengthLimitingTextInputFormatter(20),
          ],
        ),
        Space.h8,
      ],
    );
  }
}
