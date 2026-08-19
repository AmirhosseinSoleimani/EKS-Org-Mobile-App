import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_contract_image_viewer.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

class AgencyInfoContractsActionView extends StatelessWidget {
  const AgencyInfoContractsActionView({
    super.key,
    required this.item,
    required this.contracts,
  });

  final AgencyInfoEntity item;
  final AgencyContractPageEntity contracts;

  @override
  Widget build(BuildContext context) {
    final records = contracts.records ?? const <AgencyContractEntity>[];
    final count = (contracts.count ?? 0) > 0
        ? contracts.count!
        : records.length;

    return Column(
      children: [
        AgencyInfoActionAgencyHeader(item: item),
        Space.h24,
        AgencyInfoActionSectionHeader(
          title: 'قراردادهای ثبت‌شده',
          count: count,
        ),
        Space.h16,
        Expanded(
          child: records.isEmpty
              ? const EmptyListWidget()
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  itemCount: records.length,
                  separatorBuilder: (_, __) => Space.h12,
                  itemBuilder: (context, index) {
                    return _AgencyContractItem(contract: records[index]);
                  },
                ),
        ),
      ],
    );
  }
}

class _AgencyContractItem extends StatelessWidget {
  const _AgencyContractItem({required this.contract});

  final AgencyContractEntity contract;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fileBase64 = contract.fileBase64?.trim();
    final hasFile = fileBase64?.isNotEmpty == true;

    return AgencyInfoActionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListItemTitleText(
                  text: AgencyInfoActionFormatter.valueOrDash(contract.title),
                  maxLines: 2,
                ),
              ),
              Space.w8,
              StatusLabel(text: contract.isActive? 'فعال' : 'غیرفعال', color: contract.isActive ? colorScheme.onError : colorScheme.error),
            ],
          ),
          Space.h12,
          Divider(
            height: AppSize.s1,
            color: theme.dividerColor.withOpacity(0.55),
          ),
          Space.h8,
          AgencyInfoActionLabelValueRow(
            label: 'شماره قرارداد:',
            value: contract.contractNo,
          ),
          AgencyInfoActionLabelValueRow(
            label: 'تاریخ شروع:',
            value: contract.startDateJalali ?? contract.startDate,
          ),
          AgencyInfoActionLabelValueRow(
            label: 'تاریخ پایان:',
            value: contract.expireDateJalali ?? contract.expireDate,
          ),
          Space.h12,
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: hasFile
                  ? () => AgencyContractImageViewer.show(
                        context,
                        fileBase64: fileBase64!,
                      )
                  : null,
              borderRadius: BorderRadius.circular(AppSize.s6),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p4,
                  vertical: AppPadding.p8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.link_rounded,
                      size: AppSize.s18,
                      color: hasFile
                          ? colorScheme.primary
                          : colorScheme.onTertiaryFixed.withOpacity(0.55),
                    ),
                    Space.w8,
                    Text(
                      'مشاهده فایل قرارداد',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: hasFile
                            ? colorScheme.primary
                            : colorScheme.onTertiaryFixed.withOpacity(0.55),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
