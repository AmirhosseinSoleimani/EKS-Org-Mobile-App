import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_check_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selected_items_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_group_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/search_input_field.dart';
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
  String _searchText = '';

  List<SkillCertificateEntity> get _selectedItems => widget.items
      .where((item) => item.selectable == true)
      .toList(growable: false);

  List<SkillCertificateEntity> get _filteredItems {
    final query = _searchText.trim().toLowerCase();
    if (query.isEmpty) return widget.items;

    return widget.items
        .where(
          (item) => (item.title ?? '').toLowerCase().contains(query),
        )
        .toList(growable: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: SimpleAppBar(
          title: 'گواهینامه مهارت ها',
          onBack: () => Navigator.of(context).pop(false),
        ),
        body: SafeArea(
          top: false,
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
              Space.h24,
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
                            (item) => SelectableCheckItem(
                              title: _value(item.title),
                              selected: item.selectable == true,
                              enabled: false,
                              maxWidth: constraints.maxWidth,
                            ),
                          )
                          .toList(growable: false),
                    );
                  },
                ),
            ],
          ),
        ),
        bottomNavigationBar: _CloseActionBar(
          onClose: () => Navigator.of(context).pop(),
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

class _CloseActionBar extends StatelessWidget {
  const _CloseActionBar({required this.onClose});

  final VoidCallback onClose;

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
        child: InkwellButtonWidget(
          title: 'بستن',
          backgroundColor: theme.colorScheme.onPrimary,
          titleColor: theme.colorScheme.onSurfaceVariant,
          borderColor: theme.dividerColor,
          borderWidth: AppSize.s1,
          onTap: onClose,
        ),
      ),
    );
  }
}

String _value(String? value) {
  final result = value?.trim();
  return result == null || result.isEmpty ? '-' : result;
}
