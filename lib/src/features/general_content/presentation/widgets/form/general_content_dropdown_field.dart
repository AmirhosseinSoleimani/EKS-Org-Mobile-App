import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class GeneralContentDropdownField extends StatelessWidget {
  const GeneralContentDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.mandatory = false,
    this.hint = 'انتخاب کنید',
    this.validator,
  });

  final String label;
  final List<CurrentSessionEnumItemEntity> items;
  final int? value;
  final ValueChanged<int?> onChanged;
  final bool mandatory;
  final String hint;
  final String? Function(int?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normalizedItems = _uniqueItems(items);
    final validValues = normalizedItems.map((item) => item.value).toSet();
    final selectedValue = validValues.contains(value) ? value : null;

    return DropdownButtonFormField<int>(
      key: ValueKey('$label-$selectedValue-${normalizedItems.length}'),
      initialValue: selectedValue,
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: colorScheme.onTertiaryFixed,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.onPrimary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p14,
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BodyMediumText(
              text: label,
              color: colorScheme.onTertiaryFixed,
            ),
            if (mandatory) ...[
              Space.w4,
              BodySmallText(
                text: '*',
                color: colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ],
          ],
        ),
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onTertiaryFixed,
        ),
        errorStyle: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.error,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(color: colorScheme.inverseSurface),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
      items: normalizedItems
          .map(
            (item) => DropdownMenuItem<int>(
              value: item.value,
              child: BodyMediumText(
                text: item.title ?? item.name ?? '---',
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(growable: false),
      onChanged: onChanged,
      validator: validator ??
          (mandatory
              ? (selected) =>
                  selected == null ? 'انتخاب $label الزامی است.' : null
              : null),
    );
  }

  List<CurrentSessionEnumItemEntity> _uniqueItems(
    List<CurrentSessionEnumItemEntity> source,
  ) {
    final values = <int>{};
    final result = <CurrentSessionEnumItemEntity>[];

    for (final item in source) {
      final itemValue = item.value;
      if (itemValue == null || !values.add(itemValue)) continue;
      result.add(item);
    }

    return result;
  }
}
