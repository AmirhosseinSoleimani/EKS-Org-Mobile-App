import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SkillCertificateFormSheet extends StatefulWidget {
  const SkillCertificateFormSheet({super.key, this.skill});

  final SkillCertificateEntity? skill;

  @override
  State<SkillCertificateFormSheet> createState() =>
      _SkillCertificateFormSheetState();
}

class _SkillCertificateFormSheetState extends State<SkillCertificateFormSheet> {
  static const _statusPlaceholder = 'انتخاب کنید';
  static const _statusTitles = [_statusPlaceholder, 'فعال', 'غیرفعال'];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late bool? _isActive;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.skill?.title ?? '');
    _isActive = widget.skill?.id == null ? null : widget.skill?.isActive;
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
      padding: EdgeInsetsGeometry.all(AppPadding.p16),
      height: availableHeight * 0.34,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FullScreenBottomSheetAppBar(
            title: isEdit ? 'ویرایش گواهینامه' : 'ثبت گواهینامه جدید',
            onClose: () {
              context.pop();
            },
          ),
          Divider(height: 1,color: theme.dividerColor),
          Space.h24,

          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldWidget(
                      controller: _titleController,
                      labelText: 'عنوان',
                      mandatory: true,
                      maxLength: 100,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'عنوان را وارد کنید';
                        }
                        return null;
                      },
                    ),
                    Space.h16,
                    FormField<bool>(
                      initialValue: _isActive,
                      validator: (value) {
                        if (value == null) {
                          return 'وضعیت را انتخاب کنید';
                        }
                        return null;
                      },
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EkDropDown(
                              _statusTitles,
                              fillColor: Colors.white,
                              label: 'وضعیت',
                              mandatory: true,
                              selectedItem: _statusTitle(field.value),
                              onItemValue: (value) {
                                final status = _statusValue(value);
                                setState(() => _isActive = status);
                                field.didChange(status);
                              },
                            ),
                            if (field.hasError) ...[
                              Space.h8,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12,
                                ),
                                child: Text(
                                  field.errorText!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.error,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          _BottomActions(
            submitTitle: isEdit ? 'ویرایش' : 'ثبت',
            onSubmit: _submit,
            onCancel: () => Navigator.of(context).pop(),
          ),
          Space.h16,
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final saved = await context.read<SkillsCertificatesCubit>().saveSkill(
      id: widget.skill?.id,
      title: _titleController.text,
      isActive: _isActive!,
    );

    if (saved && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  String _statusTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return _statusPlaceholder;
  }

  bool? _statusValue(String value) {
    if (value == 'فعال') return true;
    if (value == 'غیرفعال') return false;
    return null;
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
