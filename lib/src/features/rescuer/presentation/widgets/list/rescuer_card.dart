import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_info_row.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_skills_preview.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_avatar.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RescuerCard extends StatelessWidget {
  final RescuerEntity item;
  final VoidCallback onViewDetails;
  final VoidCallback onOperations;
  final bool isDeleting;

  const RescuerCard({
    super.key,
    required this.item,
    required this.onViewDetails,
    required this.onOperations,
    required this.isDeleting,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = item.isActive == true || item.status == 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RescuerAvatar(imageBase64: item.imageBase64),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyMediumText(
                      text: item.fullName.isEmpty ? 'بدون نام' : item.fullName,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    BodySmallText(
                      text: 'کد پرسنلی: ${_value(item.code)}',
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              StatusLabel(
                text: isActive ? 'فعال' : 'غیرفعال',
                color: isActive ? colorScheme.onError : colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 14),

          RescuerInfoRow(
            icon: SvgManager.identityCard,
            label: 'کد ملی',
            value: _value(item.nationalNumber),
          ),

          RescuerInfoRow(
            icon: SvgManager.calendar,
            label: 'تاریخ تولد',
            value: _value(item.birthDateJalali),
          ),

          RescuerInfoRow(
            icon: SvgManager.mobilePhone,
            label: 'تلفن همراه',
            value: item.mobile?.toLocalMobile() ?? '-',
          ),

          RescuerInfoRow(
            icon: SvgManager.workStartHistory,
            label: 'تاریخ شروع',
            value: _dateOnly(item.insertDateTimeJalali),
          ),

          const SizedBox(height: 6),

          RescuerSkillsPreview(certificatesTitle: item.certificatesTitle),

          const SizedBox(height: 10),

          Row(
            children: [
              _svgIcon(
                assetPath: SvgManager.clothingSize,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              BodySmallText(
                text: 'سایز لباس: ${_value(item.clothingSize)}',
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 18),
              _svgIcon(
                assetPath: SvgManager.shoeSize,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 5),
              BodySmallText(
                text: 'سایز کفش: ${item.shoesSize?.toString() ?? '-'}',
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت‌کننده: ${_value(item.insertUserFullName)}',
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 10,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              BodySmallText(
                text: _formatDateTime(item.insertDateTimeJalali),
                color: colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
            ],
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                flex: 56,
                child: InkwellButtonWidget(
                  title: 'مشاهده جزئیات',
                  backgroundColor: const Color(0xFFF97316),
                  prefixIcon: const Icon(
                    Icons.visibility_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  showLoading: isDeleting,
                  onTap: isDeleting ? null : onViewDetails,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 44,
                child: InkwellButtonWidget(
                  title: 'عملیات',
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  titleColor: colorScheme.onSurfaceVariant,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  prefixIcon: Icon(
                    Icons.settings_outlined,
                    color: colorScheme.onSurfaceVariant,
                    size: 19,
                  ),
                  onTap: isDeleting ? null : onOperations,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _svgIcon({
    required String assetPath,
    required Color color,
    double size = 18,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  String _value(String? value) {
    final result = value?.trim();

    return result == null || result.isEmpty ? '-' : result;
  }

  String _dateOnly(String? value) {
    final result = value?.trim();

    if (result == null || result.isEmpty) {
      return '-';
    }

    return result.split(' ').first;
  }

  String _formatDateTime(String? value) {
    final result = value?.trim();

    if (result == null || result.isEmpty) {
      return '-';
    }

    final parts = result.split(' ');

    if (parts.length < 2) {
      return result;
    }

    return '${parts.first} - ${parts.last}';
  }
}
