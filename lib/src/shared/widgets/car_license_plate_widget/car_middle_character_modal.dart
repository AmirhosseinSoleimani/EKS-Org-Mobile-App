import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarMiddleCharacterModal {
  final BuildContext context;
  final ValueNotifier<String> carTag;

  CarMiddleCharacterModal({required this.context, required this.carTag});

  static const Map<String, String> _middleCharacter = {
    'الف': 'الف',
    'ب': 'ب',
    'پ': 'پ',
    'ت': 'ت',
    'ث': 'ث',
    'ج': 'ج',
    'د': 'د',
    'ز': 'ز',
    'ژ': 'ژ',
    'س': 'س',
    'ش': 'ش',
    'ص': 'ص',
    'ط': 'ط',
    'ف': 'ف',
    'ق': 'ق',
    'ک': 'ک',
    'گ': 'گ',
    'ع': 'ع',
    'ل': 'ل',
    'م': 'م',
    'ن': 'ن',
    'و': 'و',
    'ه': 'ه',
    'ی': 'ی',
    'D': 'D',
    'S': 'S',
  };

  Future<void> show() async {
    final colorScheme = Theme.of(context).colorScheme;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        final searchCtrl = TextEditingController();
        String query = '';
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: StatefulBuilder(
            builder: (ctx, setState) {
              final entries = _middleCharacter.entries.where((e) {
                if (query.trim().isEmpty) return true;
                final q = query.trim().toLowerCase();
                return e.key.toLowerCase().contains(q) ||
                    e.value.toLowerCase().contains(q);
              }).toList();

              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSize.s16),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppPadding.p16,
                    AppPadding.p8,
                    AppPadding.p16,
                    MediaQuery.of(ctx).viewInsets.bottom + AppPadding.p16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: AppSize.s8,
                          width: AppSize.s120,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(AppSize.s24),
                              ),
                              color: colorScheme.onInverseSurface,
                            ),
                          ),
                        ),
                      ),
                      Space.h8,
                      _buildSheetHeader(ctx),
                      Space.h12,
                      _buildSearchField(ctx, searchCtrl, (val) {
                        setState(() => query = val);
                      }),
                      Space.h16,
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: entries.length,
                          itemBuilder: (_, index) {
                            return _buildGridItem(ctx, entries[index], carTag);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSheetHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('انتخاب حرف پلاک', style: Theme.of(context).textTheme.titleMedium),
        IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.error,
            size: AppSize.s20,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(
    BuildContext context,
    TextEditingController controller,
    ValueChanged<String> onChanged,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormFieldWidget(
      labelText: 'جستجو... ',
      hintText: 'جستجو... ',
      suffixIcon: Icon(
        Icons.search,
        size: AppSize.s20,
        color: Theme.of(context).colorScheme.onTertiary,
      ),
      textInputAction: TextInputAction.done,
      hintStyle: textTheme.displayMedium?.copyWith(
        fontSize: AppSize.s16,
        color: colorScheme.onSecondaryFixed,
      ),
      labelStyle: textTheme.displayMedium?.copyWith(fontSize: AppSize.s16),
      textStyle: textTheme.displayMedium?.copyWith(fontSize: AppSize.s16),
      controller: controller,
      onChanged: onChanged,
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    MapEntry<String, String> entry,
    ValueNotifier<String> carTag,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: GestureDetector(
        onTap: () {
          carTag.value = entry.key;
          Navigator.of(context).pop();
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: entry.value == 'ژ'
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                    vertical: AppPadding.p8,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.wheelchair_pickup_outlined,
                      size: AppSize.s20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                    vertical: AppPadding.p8,
                  ),
                  child: Text(
                    entry.value,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(fontSize: AppSize.s16),
                  ),
                ),
        ),
      ),
    );
  }
}
