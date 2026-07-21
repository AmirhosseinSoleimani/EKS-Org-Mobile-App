import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_full_screen_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_check_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/search_input_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerSkillCertificatesSheet extends StatefulWidget {
  final RescuerEntity rescuer;
  final List<SkillCertificateEntity> items;

  const RescuerSkillCertificatesSheet({
    super.key,
    required this.rescuer,
    required this.items,
  });

  @override
  State<RescuerSkillCertificatesSheet> createState() =>
      _RescuerSkillCertificatesSheetState();
}

class _RescuerSkillCertificatesSheetState
    extends State<RescuerSkillCertificatesSheet> {
  final _searchController = TextEditingController();
  String _searchText = '';

  List<SkillCertificateEntity> get _filteredItems {
    final query = _searchText.trim().toLowerCase();
    if (query.isEmpty) return widget.items;

    return widget.items
        .where((item) {
          return (item.title ?? '').toLowerCase().contains(query);
        })
        .toList(growable: false);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: const RescuerFullScreenSheetAppBar(title: 'گواهینامه مهارت‌ها'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _CertificateProfileCard(rescuer: widget.rescuer),
                    Space.h24,
                    SearchInputField(
                      controller: _searchController,
                      hintText: 'جستجوی مهارت',
                      onChanged: (value) {
                        setState(() => _searchText = value);
                      },
                    ),
                    Space.h24,
                    if (_filteredItems.isEmpty)
                      const EmptyListWidget()
                    else
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: AppSize.s8,
                        runSpacing: AppSize.s10,
                        children: _filteredItems
                            .map((item) {
                              final isSelected = item.selectable == true;

                              return SelectableCheckItem(
                                title: _value(item.title),
                                selected: isSelected,
                                enabled: false,
                                // enabled: true,
                                // onTap: () => _onCertificateSelected(item),
                              );
                            })
                            .toList(growable: false),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s16),
            topRight: Radius.circular(AppSize.s16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(45),
              blurRadius: 10,
              offset: const Offset(-1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 16),
          child: InkwellButtonWidget(
            title: 'بستن',
            backgroundColor: Colors.white,
            titleColor: Theme.of(context).colorScheme.onSurfaceVariant,
            borderColor: Theme.of(context).colorScheme.onPrimaryFixed,
            borderWidth: 1,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    );
  }

  // void _onCertificateSelected(SkillCertificateEntity item) {
  //   // Selection will be enabled in the next implementation step.
  // }
}

class _CertificateProfileCard extends StatelessWidget {
  final RescuerEntity rescuer;

  const _CertificateProfileCard({required this.rescuer});

  @override
  Widget build(BuildContext context) {
    final isActive = rescuer.isActive == true || rescuer.status == 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFFFEDE6),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, color: Color(0xFFF97316)),
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
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFFE4F8EC)
                  : const Color(0xFFFFECEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: BodySmallText(
              text: isActive ? 'فعال' : 'غیرفعال',
              color: isActive ? const Color(0xFF16A05D) : Colors.red,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

String _value(String? value) {
  final result = value?.trim();
  return result == null || result.isEmpty ? '-' : result;
}
