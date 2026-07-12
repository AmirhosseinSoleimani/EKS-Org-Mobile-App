import 'dart:convert';
import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_detail_row.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmdadUnitCard extends StatelessWidget {
  const EmdadUnitCard({
    super.key,
    required this.item,
    required this.onEditImage,
    required this.onChangeLocation,
    required this.onPersons,
    required this.onDelete,
  });

  final EmdadUnitEntity item;
  final VoidCallback onEditImage;
  final VoidCallback onChangeLocation;
  final VoidCallback onPersons;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppMargin.m12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ImageBox(imageBase64: item.imageBase64),
                Space.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name?.trim().isNotEmpty == true
                            ? item.name!.trim()
                            : 'بدون عنوان',
                        style: theme.textTheme.titleSmall,
                      ),
                      Space.h8,
                      Wrap(
                        spacing: AppSize.s8,
                        runSpacing: AppSize.s8,
                        children: [
                          EmdadUnitStatusBadge(isActive: item.isActive),
                          if (item.score != null)
                            Chip(
                              visualDensity: VisualDensity.compact,
                              label: Text('امتیاز ${item.score}'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<_CardAction>(
                  onSelected: (action) {
                    switch (action) {
                      case _CardAction.editImage:
                        onEditImage();
                      case _CardAction.location:
                        onChangeLocation();
                      case _CardAction.persons:
                        onPersons();
                      case _CardAction.delete:
                        onDelete();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: _CardAction.editImage,
                      child: Text('ویرایش تصویر'),
                    ),
                    PopupMenuItem(
                      value: _CardAction.location,
                      child: Text('تغییر محل استقرار'),
                    ),
                    PopupMenuItem(
                      value: _CardAction.persons,
                      child: Text('امدادرسان‌ها'),
                    ),
                    PopupMenuItem(
                      value: _CardAction.delete,
                      child: Text('حذف'),
                    ),
                  ],
                ),
              ],
            ),
            Space.h12,
            EmdadUnitDetailRow(
              label: 'نمایندگی',
              value: item.agencyInfoName,
              icon: Icons.business_rounded,
            ),
            EmdadUnitDetailRow(
              label: 'خودرو',
              value: item.vehicleInfoTitle,
              icon: Icons.directions_car_rounded,
            ),
            EmdadUnitDetailRow(
              label: 'امدادرسان',
              value: item.personInfoFullName,
              icon: Icons.person_rounded,
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              title: Text(
                'جزئیات بیشتر',
                style: theme.textTheme.bodyMedium,
              ),
              children: [
                EmdadUnitDetailRow(label: 'نوع مقر', value: item.seatTypeTitle),
                EmdadUnitDetailRow(label: 'محل استقرار', value: item.locationTitle),
                EmdadUnitDetailRow(label: 'گرید', value: item.gradeTitle),
                EmdadUnitDetailRow(label: 'الگوی گرید', value: item.gradePatternName),
                EmdadUnitDetailRow(label: 'آدرس', value: item.address),
                EmdadUnitDetailRow(label: 'ثبت کننده', value: item.insertUserFullName),
                EmdadUnitDetailRow(label: 'زمان ثبت', value: item.insertDateTimeJalali),
                EmdadUnitDetailRow(label: 'ویرایش کننده', value: item.updateUserFullName),
                EmdadUnitDetailRow(label: 'زمان ویرایش', value: item.updateDateTimeJalali),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({required this.imageBase64});

  final String? imageBase64;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageBase64?.trim().isNotEmpty == true;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        width: AppSize.s64,
        height: AppSize.s64,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: hasImage
            ? Image.memory(
                _decodeImage(imageBase64!) ?? Uint8List(0),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_outlined),
              )
            : const Icon(Icons.car_repair_rounded),
      ),
    );
  }

  Uint8List? _decodeImage(String value) {
    try {
      final uriData = Uri.tryParse(value)?.data;
      if (uriData != null) {
        return uriData.contentAsBytes();
      }
      return base64Decode(value);
    } catch (_) {
      return null;
    }
  }
}

enum _CardAction { editImage, location, persons, delete }
