import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillCertificateFormSheet extends StatefulWidget {
  const SkillCertificateFormSheet({super.key, this.skill});

  final SkillCertificateEntity? skill;

  @override
  State<SkillCertificateFormSheet> createState() =>
      _SkillCertificateFormSheetState();
}

class _SkillCertificateFormSheetState extends State<SkillCertificateFormSheet> {
  static const _statusTitles = ['فعال', 'غیرفعال'];

  late final TextEditingController _titleController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.skill?.title ?? '');
    _isActive = widget.skill?.isActive ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final availableHeight =
        mediaQuery.size.height -
        mediaQuery.viewInsets.bottom -
        mediaQuery.padding.top;
    final isEdit = widget.skill?.id != null;

    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: AppPadding.p8),
      height: availableHeight * 0.34,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEdit ? 'ویرایش گواهینامه' : 'ثبت گواهینامه جدید',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Space.h24,
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Column(
                children: [
                  TextFormFieldWidget(
                    controller: _titleController,
                    labelText: 'عنوان',
                    mandatory: true,
                    maxLength: 100,
                    textInputAction: TextInputAction.next,
                  ),
                  Space.h16,
                  EkDropDown(
                    _statusTitles,
                    fillColor: Colors.white,
                    label: 'وضعیت',
                    selectedItem: _isActive ? 'فعال' : 'غیرفعال',
                    onItemValue: (value) {
                      setState(() => _isActive = value == 'فعال');
                    },
                  ),
                ],
              ),
            ),
          ),
          _BottomActions(
            submitTitle: isEdit ? 'ویرایش' : 'ثبت',
            onSubmit: _submit,
            onCancel: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final saved = await context.read<SkillsCertificatesCubit>().saveSkill(
      id: widget.skill?.id,
      title: _titleController.text,
      isActive: _isActive,
    );

    if (saved && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.submitTitle,
    required this.onSubmit,
    required this.onCancel,
  });

  final String submitTitle;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: InkwellButtonWidget(title: submitTitle, onTap: onSubmit),
        ),
        Space.w16,
        Expanded(
          child: InkwellButtonWidget(
            title: 'انصراف',
            backgroundColor: theme.colorScheme.onPrimary,
            borderColor: theme.colorScheme.outline.withOpacity(0.65),
            titleColor: theme.colorScheme.onSurface,
            onTap: onCancel,
          ),
        ),
      ],
    );
  }
}
