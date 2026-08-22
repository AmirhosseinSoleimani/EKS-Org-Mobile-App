import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_skills_preview.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_avatar.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RescuerCard extends StatelessWidget {
  const RescuerCard({
    super.key,
    required this.item,
    required this.onViewDetails,
    required this.onOperations,
    required this.isDeleting,
  });

  final RescuerEntity item;
  final VoidCallback onViewDetails;
  final VoidCallback onOperations;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = item.isActive == true || item.status == 1;

    return AppSummaryCard(
      title: item.fullName.isEmpty ? 'بدون نام' : item.fullName,
      subtitle: 'کد پرسنلی: ${_value(item.code)}',
      leading: RescuerAvatar(imageBase64: item.imageBase64),
      badges: [
        StatusLabel(
          text: isActive ? 'فعال' : 'غیرفعال',
          color: isActive ? colorScheme.onError : colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          iconWidget: _svgIcon(
            assetPath: SvgManager.identityCard,
            color: colorScheme.onPrimaryFixed,
          ),
          label: 'کد ملی',
          value: item.nationalNumber,
        ),
        SummaryCardInfo(
          iconWidget: _svgIcon(
            assetPath: SvgManager.calendar,
            color: colorScheme.onPrimaryFixed,
          ),
          label: 'تاریخ تولد',
          value: item.birthDateJalali,
        ),
        SummaryCardInfo(
          iconWidget: _svgIcon(
            assetPath: SvgManager.mobilePhone,
            color: colorScheme.onPrimaryFixed,
          ),
          label: 'تلفن همراه',
          value: item.mobile?.toLocalMobile(),
        ),
        SummaryCardInfo(
          iconWidget: _svgIcon(
            assetPath: SvgManager.workStartHistory,
            color: colorScheme.onPrimaryFixed,
          ),
          label: 'تاریخ شروع',
          value: _dateOnly(item.insertDateTimeJalali),
        ),
        SummaryCardInfo(
          iconWidget: _svgIcon(
            assetPath: SvgManager.clothingSize,
            color: colorScheme.onPrimaryFixed,
          ),
          label: 'سایز لباس',
          value: item.clothingSize,
        ),
        SummaryCardInfo(
          iconWidget: _svgIcon(
            assetPath: SvgManager.shoeSize,
            color: colorScheme.onPrimaryFixed,
          ),
          label: 'سایز کفش',
          value: item.shoesSize?.toString(),
        ),
      ],
      afterInfo: RescuerSkillsPreview(
        certificatesTitle: item.certificatesTitle,
      ),
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: _formatDateTime(item.insertDateTimeJalali),
        ),
      ],
      primaryAction: InkwellButtonWidget(
        title: 'مشاهده جزئیات',
        backgroundColor: const Color(0xFFF97316),
        prefixIcon: const Icon(
          Icons.visibility_outlined,
          color: Colors.white,
          size: AppSize.s20,
        ),
        showLoading: isDeleting,
        onTap: () {
          if (isDeleting) return;
          onViewDetails();
        },
      ),
      onOperation: onOperations,
    );
  }

  Widget _svgIcon({
    required String assetPath,
    required Color color,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: AppSize.s18,
      height: AppSize.s18,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  String _value(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? '---' : normalized;
  }

  String _dateOnly(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return '---';
    return normalized.split(' ').first;
  }

  String _formatDateTime(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return '---';

    final parts = normalized.split(' ');
    if (parts.length < 2) return normalized;
    return '${parts.first} - ${parts.last}';
  }
}
