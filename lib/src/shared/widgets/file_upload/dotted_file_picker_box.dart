import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class DottedFilePickerBox extends StatelessWidget {
  const DottedFilePickerBox({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    this.selected = false,
    this.height = 190,
    this.icon = Icons.upload_file_outlined,
    this.selectedIcon = Icons.check_circle,
    this.fileName,
    this.previewBytes,
    this.isImage = false,
    this.onRemove,
  });

  final String title;
  final String description;
  final VoidCallback onTap;
  final bool selected;
  final double height;
  final IconData icon;
  final IconData selectedIcon;
  final String? fileName;
  final Uint8List? previewBytes;
  final bool isImage;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: selected ? null : onTap,
          borderRadius: BorderRadius.circular(AppSize.s12),
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: const Radius.circular(AppSize.s12),
              color: const Color(0xFFDEC1AF),
              strokeWidth: AppSize.s1,
              dashPattern: const [6, 3],
            ),
            child: Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: selected ? _selectedContent(context: context,
                  boxIcon: icon) : _EmptyContent(
                title: title,
                description: description,
                icon: icon,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectedContent(
      {required BuildContext context, required IconData boxIcon}) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final bytes = previewBytes;
    if (isImage && bytes != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Space.h16,
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: Image.memory(
                bytes,
                width: AppSize.s150,
                height: AppSize.s110,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          if (selected && onRemove != null) ...[
            Space.h16,
            InkwellButtonWidget(
              backgroundColor: colorScheme.error,
              suffixIcon: Icon(
                Icons.delete_outline, color: colorScheme.onPrimary,
                size: 18,),
              width: 140,
              height: 30,
              onTap: onRemove!,
              title: 'حذف ',
            ),
            Space.h16,
          ],
        ],
      );
    }

    return _AttachedFileContent(
      icon: boxIcon,
      fileName: fileName,
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final primary = colorScheme.primary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: primary,
            size: AppSize.s42,
          ),
          Space.h8,
          BodyMediumText(
            text: title,
            color: primary,
            fontWeight: FontWeight.w700,
          ),
          Space.h4,
          BodyMediumText(
            text: description,
            fontSize: AppSize.s12,
            color: colorScheme.onTertiaryFixed,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AttachedFileContent extends StatelessWidget {
  const _AttachedFileContent({
    required this.icon,
    this.fileName,
  });

  final IconData icon;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSize.s60,
            height: AppSize.s60,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: AppSize.s32,
            ),
          ),
          Space.h12,
          BodyMediumText(
            text: 'فایل پیوست شد',
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
          if (fileName
              ?.trim()
              .isNotEmpty == true) ...[
            Space.h4,
            BodySmallText(
              text: fileName!,
              color: colorScheme.onTertiaryFixed,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _RemoveFileButton extends StatelessWidget {
  const _RemoveFileButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.error,
              size: AppSize.s20,
            ),
            const SizedBox(width: AppSize.s6),
            BodyMediumText(
              text: 'حذف',
              color: colorScheme.error,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
