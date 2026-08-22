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
    this.isLoading = false,
    this.height = 190,
    this.icon = Icons.upload_file_outlined,
    this.fileName,
    this.previewBytes,
    this.isImage = false,
    this.onRemove,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool selected;
  final bool isLoading;
  final double height;
  final IconData icon;
  final String? fileName;
  final Uint8List? previewBytes;
  final bool isImage;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: selected || onTap == null
          ? null
          : () {
              if (isLoading) return;
              onTap?.call();
            },
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
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : selected
                  ? _SelectedContent(
                      icon: icon,
                      fileName: fileName,
                      previewBytes: previewBytes,
                      isImage: isImage,
                      onRemove: onRemove,
                    )
                  : _EmptyContent(
                      title: title,
                      description: description,
                      icon: icon,
                    ),
        ),
      ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: colorScheme.primary, size: AppSize.s42),
          Space.h8,
          BodyMediumText(
            text: title,
            color: colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
          Space.h4,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: BodyMediumText(
              text: description,
              fontSize: AppSize.s12,
              color: colorScheme.onTertiaryFixed,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedContent extends StatelessWidget {
  const _SelectedContent({
    required this.icon,
    required this.isImage,
    this.fileName,
    this.previewBytes,
    this.onRemove,
  });

  final IconData icon;
  final String? fileName;
  final Uint8List? previewBytes;
  final bool isImage;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final bytes = previewBytes;
    if (isImage && bytes != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: Image.memory(
              bytes,
              width: AppSize.s150,
              height: AppSize.s110,
              fit: BoxFit.cover,
            ),
          ),
          if (onRemove != null) ...[
            Space.h12,
            InkwellButtonWidget(
              backgroundColor: Theme.of(context).colorScheme.error,
              suffixIcon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.onPrimary,
                size: AppSize.s18,
              ),
              width: 140,
              height: 30,
              onTap: onRemove!,
              title: 'حذف',
            ),
          ],
        ],
      );
    }

    final colorScheme = Theme.of(context).colorScheme;
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
            child: Icon(icon, color: colorScheme.primary, size: AppSize.s32),
          ),
          Space.h12,
          BodyMediumText(
            text: 'فایل پیوست شد',
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
          if (fileName?.trim().isNotEmpty == true) ...[
            Space.h4,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
              child: BodySmallText(
                text: fileName!,
                color: colorScheme.onTertiaryFixed,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
