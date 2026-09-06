import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/submit_skill_certificates_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/submit_rescuer_skill_certificates_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart'
    show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_check_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selected_items_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_group_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/search_input_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerSkillCertificatesSheet extends StatefulWidget {
  const RescuerSkillCertificatesSheet({
    super.key,
    required this.rescuer,
    required this.items,
  });

  final RescuerEntity rescuer;
  final List<SkillCertificateEntity> items;

  @override
  State<RescuerSkillCertificatesSheet> createState() =>
      _RescuerSkillCertificatesSheetState();
}

class _RescuerSkillCertificatesSheetState
    extends State<RescuerSkillCertificatesSheet> {
  final TextEditingController _searchController = TextEditingController();
  late List<SkillCertificateEntity> _items;
  String _searchText = '';
  bool _isSubmitting = false;

  List<SkillCertificateEntity> get _selectedItems => _items
      .where((item) => item.selectable == true)
      .toList(growable: false);

  List<SkillCertificateEntity> get _filteredItems {
    final query = _searchText.trim().toLowerCase();
    if (query.isEmpty) return _items;

    return _items
        .where(
          (item) => (item.title ?? '').toLowerCase().contains(query),
        )
        .toList(growable: false);
  }

  bool get _allSelected {
    final validItems = _items.where((item) => item.id != null).toList();
    return validItems.isNotEmpty &&
        validItems.every((item) => item.selectable == true);
  }

  @override
  void initState() {
    super.initState();
    _items = List<SkillCertificateEntity>.from(widget.items);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleCertificate(SkillCertificateEntity certificate) {
    if (_isSubmitting || certificate.id == null) return;

    setState(() {
      _items = _items.map((item) {
        if (item.id != certificate.id) return item;
        return item.copyWith(selectable: item.selectable != true);
      }).toList(growable: false);
    });
  }

  void _setAll(bool selected) {
    if (_isSubmitting) return;

    setState(() {
      _items = _items
          .map(
            (item) => item.id == null
                ? item
                : item.copyWith(selectable: selected),
          )
          .toList(growable: false);
    });
  }

  Future<void> _submit() async {
    final personInfoId = widget.rescuer.id;
    if (_isSubmitting || personInfoId == null) return;

    setState(() => _isSubmitting = true);

    final selectedIds = _items
        .where((item) => item.selectable == true && item.id != null)
        .map((item) => item.id!)
        .toList(growable: false);

    final useCase = SubmitRescuerSkillCertificatesUseCase(
      getIt<RescuerRepository>(),
    );

    final result = await useCase(
      SubmitSkillCertificatesParamEntity(
        skillCertificateIds: selectedIds,
        personInfoId: personInfoId,
      ),
    );

    if (!mounted) return;

    String? successMessage;
    String? errorMessage;

    result.whenOrNull(
      success: (data, failures, resultCode) {
        successMessage = data.message;
      },
      failure: (error, message) {
        errorMessage =
            message ??
            error?.toString() ??
            'ثبت گواهینامه‌های مهارت با خطا مواجه شد.';
      },
      connectionError: () {
        errorMessage = 'اتصال اینترنت خود را بررسی کنید.';
      },
    );

    if (successMessage?.isNotEmpty == true) {
      Navigator.of(context).pop<String>(successMessage);
      return;
    }

    setState(() => _isSubmitting = false);

    SnakeBarWidget.showError(
      context: context,
      message: errorMessage ?? 'ثبت گواهینامه‌های مهارت با خطا مواجه شد.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: SimpleAppBar(
          title: 'گواهینامه مهارت ها',
          onBack: _isSubmitting
              ? () {}
              : () => Navigator.of(context).pop<String>(),
        ),
        body: SafeArea(
          top: false,
          child: IgnorePointer(
            ignoring: _isSubmitting,
            child: ListView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(AppPadding.p16),
              children: [
                _CertificateProfileCard(rescuer: widget.rescuer),
                Space.h24,
                if (_selectedItems.isNotEmpty) ...[
                  SelectedItemsSection<SkillCertificateEntity>(
                    title: 'گواهینامه های انتخاب شده',
                    items: _selectedItems,
                    itemTitle: (item) => _value(item.title),
                  ),
                  Space.h24,
                ],
                SearchInputField(
                  controller: _searchController,
                  hintText: 'جستجوی مهارت',
                  onChanged: (value) => setState(() => _searchText = value),
                ),
                Space.h20,
                _SelectAllTile(
                  value: _allSelected,
                  enabled: !_isSubmitting,
                  onChanged: _setAll,
                ),
                Space.h20,
                const SelectionGroupHeader(
                  title: 'گواهینامه های مهارت',
                  icon: Icons.workspace_premium_outlined,
                ),
                Space.h12,
                if (_filteredItems.isEmpty)
                  const EmptyListWidget()
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        spacing: AppSize.s8,
                        runSpacing: AppSize.s10,
                        children: _filteredItems
                            .map(
                              (item) => InkWell(
                                onTap: item.id == null
                                    ? null
                                    : () => _toggleCertificate(item),
                                borderRadius: BorderRadius.circular(
                                  AppSize.s8,
                                ),
                                child: SelectableCheckItem(
                                  title: _value(item.title),
                                  selected: item.selectable == true,
                                  enabled: !_isSubmitting && item.id != null,
                                  maxWidth: constraints.maxWidth,
                                ),
                              ),
                            )
                            .toList(growable: false),
                      );
                    },
                  ),
                Space.h24,
              ],
            ),
          ),
        ),
        bottomNavigationBar: _SkillCertificateActions(
          isSubmitting: _isSubmitting,
          onClose: () => Navigator.of(context).pop<String>(),
          onSubmit: _submit,
        ),
      ),
    );
  }
}

class _SelectAllTile extends StatelessWidget {
  const _SelectAllTile({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? () => onChanged(!value) : null,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: enabled
                  ? (checked) => onChanged(checked ?? false)
                  : null,
            ),
            Space.w8,
            const BodyMediumText(
              text: 'همه',
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillCertificateActions extends StatelessWidget {
  const _SkillCertificateActions({
    required this.isSubmitting,
    required this.onClose,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final VoidCallback onClose;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p28,
          AppPadding.p12,
          AppPadding.p28,
          AppPadding.p16,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withAlpha(24),
              blurRadius: AppSize.s10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: InkwellButtonWidget(
                title: 'بستن',
                backgroundColor: theme.colorScheme.onPrimary,
                titleColor: theme.colorScheme.onSurfaceVariant,
                borderColor: theme.dividerColor,
                borderWidth: AppSize.s1,
                onTap: () {
                  if (isSubmitting) return;
                  onClose();
                },
              ),
            ),
            Space.w12,
            Expanded(
              child: InkwellButtonWidget(
                title: 'ثبت',
                showLoading: isSubmitting,
                backgroundColor: theme.colorScheme.primary,
                onTap: () {
                  if (isSubmitting) return;
                  onSubmit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CertificateProfileCard extends StatelessWidget {
  const _CertificateProfileCard({required this.rescuer});

  final RescuerEntity rescuer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = rescuer.isActive == true || rescuer.status == 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: AppSize.s18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppSize.s48,
            height: AppSize.s48,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: theme.colorScheme.primary,
            ),
          ),
          Space.w16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyMediumText(
                  text: rescuer.fullName.isEmpty
                      ? 'بدون نام'
                      : rescuer.fullName,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                Space.h4,
                BodySmallText(
                  text: 'کد پرسنلی: ${_value(rescuer.code)}',
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          _StatusBadge(isActive: isActive),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFE4F8EC)
            : const Color(0xFFFFECEC),
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: BodySmallText(
        text: isActive ? 'فعال' : 'غیرفعال',
        color: isActive ? const Color(0xFF16A05D) : Colors.red,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

String _value(String? value) {
  final result = value?.trim();
  return result == null || result.isEmpty ? '-' : result;
}
