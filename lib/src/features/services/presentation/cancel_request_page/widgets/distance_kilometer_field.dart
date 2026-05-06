import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class DistanceKilometerField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<bool> isEditableNotifier;
  final ValueNotifier<bool> isLoadingNotifier;
  final VoidCallback onGetDistance;

  const DistanceKilometerField({
    super.key,
    required this.controller,
    required this.isEditableNotifier,
    required this.isLoadingNotifier,
    required this.onGetDistance,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isEditableNotifier,
      builder: (context, isEditable, _) {
        return TextFormFieldWidget(
          controller: controller,
          labelText: "کیلومتر طی شده",
          hintText: "مقدار کیلومتر",
          textInputType: TextInputType.number,
          readOnly: !isEditable,
          suffixIcon: ValueListenableBuilder<bool>(
            valueListenable: isLoadingNotifier,
            builder: (context, isLoading, __) {
              return InkWell(
                onTap: isLoading ? null : onGetDistance,
                child: Container(
                  margin: const EdgeInsets.all(AppSize.s6),
                  padding: const EdgeInsets.all(AppSize.s6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey.shade400,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey.shade400,
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
