import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_additional_information_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_service_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_detail_row.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_details_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionDetailSheet extends StatelessWidget {
  const AgencyInfoActionDetailSheet({
    super.key,
    required this.actionType,
    required this.item,
    this.actionData,
  });

  final AgencyInfoActionType actionType;
  final AgencyInfoEntity item;
  final Object? actionData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p16,
            AppPadding.p12,
            AppPadding.p16,
            AppPadding.p8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _title(actionType),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
        const Divider(height: AppSize.s1),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    switch (actionType) {
      case AgencyInfoActionType.contracts:
        final page = actionData is AgencyContractPageEntity
            ? actionData! as AgencyContractPageEntity
            : null;
        final records = page?.records ?? const [];
        return _ActionList(
          emptyTitle: 'قراردادی برای این نمایندگی ثبت نشده است.',
          itemCount: records.length,
          itemBuilder: (context, index) {
            final contract = records[index];
            return _ActionCard(
              children: [
                AgencyInfoDetailRow(label: 'عنوان', value: contract.title),
                AgencyInfoDetailRow(label: 'شماره قرارداد', value: contract.contractNo),
                AgencyInfoDetailRow(label: 'نوع فایل', value: contract.fileTypeTitle),
                AgencyInfoDetailRow(
                  label: 'شروع',
                  value: contract.startDateJalali ?? contract.startDate,
                ),
                AgencyInfoDetailRow(
                  label: 'پایان',
                  value: contract.expireDateJalali ?? contract.expireDate,
                ),
              ],
            );
          },
        );
      case AgencyInfoActionType.activeReliefWorkers:
        final page = actionData is AgencyPersonPageEntity
            ? actionData! as AgencyPersonPageEntity
            : null;
        final records = page?.records ?? const [];
        return _ActionList(
          emptyTitle: 'امدادرسان فعالی برای این نمایندگی ثبت نشده است.',
          itemCount: records.length,
          itemBuilder: (context, index) {
            final person = records[index];
            return _ActionCard(
              children: [
                AgencyInfoDetailRow(
                  label: 'نام',
                  value: [person.firstName, person.lastName]
                      .where((item) => item?.trim().isNotEmpty == true)
                      .join(' '),
                ),
                AgencyInfoDetailRow(label: 'کد', value: person.code),
                AgencyInfoDetailRow(label: 'کد ملی', value: person.nationalNumber),
                AgencyInfoDetailRow(label: 'موبایل', value: person.mobile),
                AgencyInfoDetailRow(label: 'وضعیت', value: person.statusTitle),
              ],
            );
          },
        );
      case AgencyInfoActionType.activeVehicles:
        final page = actionData is AgencyVehiclePageEntity
            ? actionData! as AgencyVehiclePageEntity
            : null;
        final records = page?.records ?? const [];
        return _ActionList(
          emptyTitle: 'خودروی فعالی برای این نمایندگی ثبت نشده است.',
          itemCount: records.length,
          itemBuilder: (context, index) {
            final vehicle = records[index];
            return _ActionCard(
              children: [
                AgencyInfoDetailRow(label: 'مدل', value: vehicle.vehicleModelTitle),
                AgencyInfoDetailRow(label: 'پلاک', value: vehicle.licensePlate),
                AgencyInfoDetailRow(label: 'شماره شاسی', value: vehicle.chassisNo),
                AgencyInfoDetailRow(label: 'شماره موتور', value: vehicle.engineNumber),
                AgencyInfoDetailRow(label: 'وضعیت', value: vehicle.statusTitle),
              ],
            );
          },
        );
      case AgencyInfoActionType.serviceType:
        final records = actionData is List<AgencyServiceTypeEntity>
            ? actionData! as List<AgencyServiceTypeEntity>
            : const <AgencyServiceTypeEntity>[];
        return _ActionList(
          emptyTitle: 'نوع خدمتی برای این نمایندگی ثبت نشده است.',
          itemCount: records.length,
          itemBuilder: (context, index) {
            final serviceType = records[index];
            return _ActionCard(
              children: [
                AgencyInfoDetailRow(label: 'کد', value: serviceType.code),
                AgencyInfoDetailRow(label: 'نام', value: serviceType.name),
                AgencyInfoDetailRow(
                  label: 'قابل انتخاب',
                  value: serviceType.selectable == true ? 'بله' : 'خیر',
                ),
              ],
            );
          },
        );
      case AgencyInfoActionType.complementaryInfo:
        final info = actionData is AgencyAdditionalInformationEntity
            ? actionData! as AgencyAdditionalInformationEntity
            : null;
        return ListView(
          padding: const EdgeInsets.all(AppPadding.p16),
          children: [
            _ActionCard(
              children: [
                AgencyInfoDetailRow(label: 'شناسه ملی', value: info?.agencyNationalId),
                AgencyInfoDetailRow(label: 'کد رهگیری', value: info?.trackingNumber),
                AgencyInfoDetailRow(label: 'کد تفصیلی', value: info?.detailedCode),
                AgencyInfoDetailRow(
                  label: 'پرونده مالیاتی',
                  value: info?.taxFileCompleted == true ? 'تکمیل شده' : 'تکمیل نشده',
                ),
              ],
            ),
          ],
        );
      case AgencyInfoActionType.history:
        final records = actionData is List<AgencyHistoryEntity>
            ? actionData! as List<AgencyHistoryEntity>
            : const <AgencyHistoryEntity>[];
        return _ActionList(
          emptyTitle: 'تاریخچه‌ای برای این نمایندگی ثبت نشده است.',
          itemCount: records.length,
          itemBuilder: (context, index) {
            final history = records[index];
            return _ActionCard(
              children: [
                AgencyInfoDetailRow(label: 'شرح', value: history.description),
                AgencyInfoDetailRow(label: 'کاربر', value: history.insertUserName),
                AgencyInfoDetailRow(label: 'تاریخ', value: history.insertDateTimeJalali),
                AgencyInfoDetailRow(label: 'نوع', value: history.entityTypeTitle),
              ],
            );
          },
        );
      case AgencyInfoActionType.changeStatus:
      case AgencyInfoActionType.delete:
        return AgencyInfoDetailsSection(item: item);
    }
  }

  String _title(AgencyInfoActionType actionType) {
    switch (actionType) {
      case AgencyInfoActionType.contracts:
        return 'قراردادها';
      case AgencyInfoActionType.activeReliefWorkers:
        return 'امدادرسان‌های فعلی';
      case AgencyInfoActionType.activeVehicles:
        return 'خودروهای فعلی';
      case AgencyInfoActionType.changeStatus:
        return 'تغییر وضعیت';
      case AgencyInfoActionType.serviceType:
        return 'نوع خدمات';
      case AgencyInfoActionType.complementaryInfo:
        return 'اطلاعات تکمیلی';
      case AgencyInfoActionType.history:
        return 'تاریخچه';
      case AgencyInfoActionType.delete:
        return 'حذف نمایندگی';
    }
  }
}

class _ActionList extends StatelessWidget {
  const _ActionList({
    required this.emptyTitle,
    required this.itemCount,
    required this.itemBuilder,
  });

  final String emptyTitle;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const EmptyListWidget(),
              Space.h16,
              Text(emptyTitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppPadding.p16),
      itemCount: itemCount,
      separatorBuilder: (_, __) => Space.h12,
      itemBuilder: itemBuilder,
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Column(children: children),
    );
  }
}
