import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
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
    final items = <String>[
      'همه',
      ...widget.contentTypes
          .map((item) => item.title ?? item.name ?? '')
          .where((item) => item.trim().isNotEmpty),
    ];

    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _apply,
      onClear: _clear,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _titleController,
            labelText: 'عنوان',
            textInputAction: TextInputAction.done,
          ),
          Space.h12,
          EkDropDown(
            items.isEmpty ? const ['همه'] : items,
            label: 'نوع',
            selectedItem: _selectedType?.title ?? _selectedType?.name ?? 'همه',
            onItemValue: (value) {
              setState(() {
                _selectedType = value == 'همه'
                    ? null
                    : widget.contentTypes.firstWhere(
                        (item) => item.title == value || item.name == value,
                        orElse: () => const CurrentSessionEnumItemEntity(),
                      );
                if (_selectedType?.value == null) _selectedType = null;
              });
            },
          ),
        ],
      ),
    );
  }

  void _apply() {
    FocusScope.of(context).unfocus();
    widget.onSubmit(_titleController.text, _selectedType);
    context.pop();
  }

  void _clear() {
    FocusScope.of(context).unfocus();
    widget.onSubmit(null, null);
    context.pop();
  }
}
