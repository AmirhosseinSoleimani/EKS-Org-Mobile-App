import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/add_agency_contract_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_contract_image_viewer.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AgencyContractsPage extends StatelessWidget {
  static const path = '/agency-contracts-page';
  static const name = 'agency-contracts-page';

  const AgencyContractsPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AgencyInfoCubit>()
        ..loadActionData(AgencyInfoActionType.contracts, agency),
      child: _AgencyContractsView(agency: agency),
    );
  }
}

class _AgencyContractsView extends StatelessWidget {
  const _AgencyContractsView({required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AgencyInfoCubit>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const SimpleAppBar(title: 'قراردادها'),
      floatingActionButton: FloatingActionButtonWidget(
        title: 'قرار داد جدید',
        onPressed: () => _openAddContract(context, cubit),
      ),
      body: BlocConsumer<AgencyInfoCubit, AgencyInfoState>(
        listener: (context, state) {
          final message = state.data.errorMessage;
          if (message?.isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: message!);
          }
          if (state.status == AgencyInfoViewStatus.connectionError) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.retryLastAction),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          }
        },
        builder: (context, state) {
          final loading = state.status == AgencyInfoViewStatus.actionLoading &&
              state.data.actionType == AgencyInfoActionType.contracts;
          final contracts = state.data.actionData is AgencyContractPageEntity
              ? state.data.actionData! as AgencyContractPageEntity
              : const AgencyContractPageEntity(records: [], count: 0);

          final hasInitialLoadError =
              (state.status == AgencyInfoViewStatus.actionError ||
                      state.status == AgencyInfoViewStatus.connectionError) &&
                  (contracts.records ?? const []).isEmpty;

          if (loading && (contracts.records ?? const []).isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (hasInitialLoadError) {
            return const SizedBox.expand(
              child: Center(child: EmptyListWidget()),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _reload(cubit),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p100,
              ),
              children: [
                AgencyInfoActionAgencyHeader(item: agency),
                Space.h24,
                ListSectionHeader(
                  title: 'قراردادهای ثبت‌شده',
                  countText: '${_count(contracts)} مورد',
                ),
                Space.h16,
                _ContractsList(contracts: contracts),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _openAddContract(
    BuildContext context,
    AgencyInfoCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(
      AddAgencyContractPage.name,
      extra: agency,
    );
    if (changed == true) {
      await _reload(cubit);
      if (context.mounted) {
        SnakeBarWidget.showSuccess(
          context: context,
          message: 'قرارداد با موفقیت ثبت شد.',
        );
      }
    }
  }

  Future<void> _reload(AgencyInfoCubit cubit) {
    return cubit.loadActionData(AgencyInfoActionType.contracts, agency);
  }

  int _count(AgencyContractPageEntity contracts) {
    final records = contracts.records;
    final count = contracts.count;
    return count != null && count > 0 ? count : (records ?? const []).length;
  }
}


class _ContractsList extends StatelessWidget {
  const _ContractsList({required this.contracts});

  final AgencyContractPageEntity contracts;

  @override
  Widget build(BuildContext context) {
    final records = contracts.records ?? const <AgencyContractEntity>[];
    if (records.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppPadding.p32),
        child: EmptyListWidget(),
      );
    }

    return Column(
      children: [
        for (final contract in records) ...[
          _AgencyContractCard(contract: contract),
          Space.h12,
        ],
      ],
    );
  }
}

class _AgencyContractCard extends StatelessWidget {
  const _AgencyContractCard({required this.contract});

  final AgencyContractEntity contract;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fileBase64 = contract.fileBase64?.trim();
    final hasFile = fileBase64?.isNotEmpty == true;
    final isActive = contract.isActive;
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
                ),
              ),
              Space.w8,
              StatusLabel(text: isActive ? 'فعال' : 'غیرفعال', color: isActive ? colorScheme.onError : colorScheme.error),
            ],
          ),
          Space.h12,
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
                    BodyMediumText(
                      text: 'مشاهده فایل قرارداد',
                      color: hasFile
                          ? colorScheme.primary
                          : colorScheme.onTertiaryFixed.withOpacity(0.55),
                      fontWeight: FontWeight.w500,
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
