import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_full_screen_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerHistoryPage extends StatelessWidget {
  static const path = '/rescuer-history';
  static const name = 'rescuer-history';

  final RescuerEntity rescuer;
  final List<SanHistoryEntity> histories;

  const RescuerHistoryPage({
    super.key,
    required this.rescuer,
    required this.histories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: const RescuerFullScreenSheetAppBar(title: 'تاریخچه'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _HistoryProfileCard(rescuer: rescuer),
                    const SizedBox(height: 26),
                    if (histories.isEmpty)
                      const _EmptyHistoryCard()
                    else
                      ...histories.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _HistoryLogCard(item: item),
                        ),
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
}

class _HistoryProfileCard extends StatelessWidget {
  final RescuerEntity rescuer;

  const _HistoryProfileCard({required this.rescuer});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEDE6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Color(0xFFF97316),
                ),
              ),
              Space.w16,
              BodyMediumText(
                text: rescuer.fullName.isEmpty ? 'بدون نام' : rescuer.fullName,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Theme.of(context).dividerColor, height: 1),
          const SizedBox(height: 10),
          _HistoryInfoPill(
            icon: Icons.calendar_today_outlined,
            text: _value(rescuer.certificatesTitle),
          ),
          const SizedBox(height: 10),
          _HistoryInfoPill(
            icon: Icons.location_on_outlined,
            text: _joinValues([
              rescuer.provinceNameIssuingPlace,
              rescuer.cityNameIssuingPlace,
              rescuer.address,
            ]),
            iconColor: colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _HistoryInfoPill extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;

  const _HistoryInfoPill({
    required this.text,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BodyMediumText(
              text: text,
              textAlign: TextAlign.right,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryLogCard extends StatelessWidget {
  final SanHistoryEntity item;

  const _HistoryLogCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BodySmallText(
                text: _value(item.insertDateTimeJalali),
                color: colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
              const SizedBox(width: 12),
              BodySmallText(
                text: 'ثبت‌کننده: ${_value(item.insertUserName)}',
                color: colorScheme.onSurfaceVariant,
                fontSize: 11,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 18),
          BodyMediumText(
            text: _value(item.description),
            textAlign: TextAlign.right,
            lineHeight: 1.8,
          ),
        ],
      ),
    );
  }
}

class _EmptyHistoryCard extends StatelessWidget {
  const _EmptyHistoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const BodyMediumText(
        text: 'تاریخچه‌ای ثبت نشده است.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

String _value(String? value) {
  final result = value?.trim();
  return result == null || result.isEmpty ? '-' : result;
}

String _joinValues(List<String?> values) {
  final cleanValues = values
      .map((value) => value?.trim())
      .whereType<String>()
      .where((value) => value.isNotEmpty)
      .toList(growable: false);
  return cleanValues.isEmpty ? '-' : cleanValues.join('، ');
}
