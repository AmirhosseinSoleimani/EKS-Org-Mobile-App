import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActionTextField extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;
  final String hintText;

  final bool readOnly;
  final ValueListenable<bool>? readOnlyListenable;

  final bool isLoading;
  final ValueListenable<bool>? loadingListenable;

  final TextInputType? keyboardType;

  final IconData actionIcon;

  final VoidCallback? onActionTap;

  const ActionTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.onActionTap,
    this.readOnly = false,
    this.readOnlyListenable,
    this.isLoading = false,
    this.loadingListenable,
    this.keyboardType,
    this.actionIcon = Icons.search,
  });

  @override
  Widget build(BuildContext context) {
    if (readOnlyListenable != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: readOnlyListenable!,
        builder: (_, readOnlyValue, _) {
          return _buildTextField(readOnlyValue);
        },
      );
    }

    return _buildTextField(readOnly);
  }

  Widget _buildTextField(bool readOnlyValue) {
    return TextFormFieldWidget(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      textInputType: keyboardType,
      readOnly: readOnlyValue,
      suffixIcon: loadingListenable != null
          ? ValueListenableBuilder<bool>(
        valueListenable: loadingListenable!,
        builder: (_, loading, _) {
          return _buildAction(loading);
        },
      )
          : _buildAction(isLoading),
    );
  }

  Widget _buildAction(bool loading) {
    return InkWell(
      onTap: loading ? null : onActionTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        margin: const EdgeInsets.all(AppSize.s6),
        padding: const EdgeInsets.all(AppSize.s6),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: loading
              ? SizedBox(
            key: const ValueKey('loading'),
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
            actionIcon,
            key: const ValueKey('icon'),
            size: 20,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
