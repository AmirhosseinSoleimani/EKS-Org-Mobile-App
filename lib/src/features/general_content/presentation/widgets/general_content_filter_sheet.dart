import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeneralContentFilterSheet extends StatefulWidget {
  const GeneralContentFilterSheet({
    super.key,
    required this.contentTypes,
    required this.initialTitle,
    required this.initialContentType,
    required this.onSubmit,
  });

  final List<CurrentSessionEnumItemEntity> contentTypes;
  final String? initialTitle;
  final CurrentSessionEnumItemEntity? initialContentType;
  final void Function(String? title, CurrentSessionEnumItemEntity? type)
      onSubmit;

  @override
  State<GeneralContentFilterSheet> createState() =>
      _GeneralContentFilterSheetState();
}

class _GeneralContentFilterSheetState extends State<GeneralContentFilterSheet> {
  late final TextEditingController _titleController;
  CurrentSessionEnumItemEntity? _selectedType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _selectedType = widget.initialContentType;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = <String>[
      'همه',
      ...widget.contentTypes
          .map((item) => item.title ?? item.name ?? '')
          .where((item) => item.trim().isNotEmpty),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p16,
            AppPadding.p8,
            AppPadding.p16,
            AppPadding.p24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: AppSize.s48,
                  height: AppSize.s4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
              ),
              Space.h20,
              TitleMediumText(
                text: 'فیلترها',
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
              Space.h20,
              TextFormFieldWidget(
                controller: _titleController,
                labelText: 'عنوان',
                textInputAction: TextInputAction.done,
              ),
              Space.h16,
              EkDropDown(
                items.isEmpty ? const ['همه'] : items,
                label: 'نوع',
                selectedItem: _selectedType?.title ?? _selectedType?.name ?? 'همه',
                onItemValue: (value) {
                  setState(() {
                    _selectedType = value == 'همه'
                        ? null
                        : widget.contentTypes.firstWhere(
                            (item) =>
                                item.title == value || item.name == value,
                            orElse: () => const CurrentSessionEnumItemEntity(),
                          );
                    if (_selectedType?.value == null) _selectedType = null;
                  });
                },
              ),
              Space.h24,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        widget.onSubmit(
                          _titleController.text,
                          _selectedType,
                        );
                        context.pop();
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'حذف فیلتر',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor:
                          theme.colorScheme.outlineVariant.withOpacity(0.4),
                      titleColor: theme.colorScheme.onSurface,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        widget.onSubmit(null, null);
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
