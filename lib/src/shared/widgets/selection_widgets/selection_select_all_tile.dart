import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:flutter/material.dart';

class SelectionSelectAllTile extends StatelessWidget {
  const SelectionSelectAllTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.title = 'انتخاب همه',
    this.enabled = true,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCheckboxWidget(
          title: title,
          value: value,
          enabled: enabled,
          onChanged: onChanged,
        ),
        Divider(
          height: AppSize.s24,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }
}
