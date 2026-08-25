import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/customer_invoice_summary_card.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_list_section_header.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_pre_invoices/cubit/customer_pre_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_pre_invoices/widgets/customer_pre_invoice_preview_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/list_filter_toolbar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerPreInvoicePage extends StatelessWidget {
  const CustomerPreInvoicePage({super.key});

  static const String path = '/customer-pre-invoices';
  static const String name = 'customer-pre-invoices';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomerPreInvoiceCubit>()..initialize(),
      child: const _CustomerPreInvoiceView(),
    );
  }
}

class _CustomerPreInvoiceView extends StatelessWidget {
  const _CustomerPreInvoiceView();

  static const _subscriptionOptions = <StatusFilterOption<bool?>>[
    StatusFilterOption<bool?>(value: null, label: 'همه'),
    StatusFilterOption<bool?>(value: true, label: 'مشترک'),
    StatusFilterOption<bool?>(value: false, label: 'غیر مشترک'),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerPreInvoiceCubit>();
    final theme = Theme.of(context);

    return BlocListener<CustomerPreInvoiceCubit, CustomerPreInvoiceState>(
      listener: (context, state) => _listenState(context, cubit, state),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'پیش فاکتورهای مشتری'),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: const {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: BlocBuilder<CustomerPreInvoiceCubit, CustomerPreInvoiceState>(
            builder: (context, state) {
              final serviceColor =
                  state.filter.serviceType?.serviceColor ??
                  ServiceType.reliefService.serviceColor;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p0,
                    ),
                    child: Column(
                      children: [
                        ListFilterToolbar<bool?>(
                          onFilterTap: () => _showFilter(
                            context,
                            cubit,
                            state,
                          ),
                          statusValue: state.selectedSubscription,
                          statusOptions: _subscriptionOptions,
                          statusPlaceholder: 'وضعیت اشتراک',
                          onStatusChanged: cubit.setSubscriptionFilter,
                        ),
                        Space.h16,
                        ReportButtonWidget(
                          isLoading: state.isReportLoading,
                          onTap: cubit.exportReport,
                        ),
                        Space.h24,
                        InvoiceListSectionHeader(
                          title: 'پیش فاکتورهای فعلی',
                          count: state.totalCount,
                          accentColor: serviceColor,
                        ),
                        Space.h12,
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildContent(
                      context,
                      cubit,
                      state,
                      serviceColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CustomerPreInvoiceCubit cubit,
    CustomerPreInvoiceState state,
    Color serviceColor,
  ) {
    if (state.isInitialLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if ((state.status == CustomerPreInvoiceViewStatus.error ||
            state.status == CustomerPreInvoiceViewStatus.connectionError) &&
        state.items.isEmpty) {
      return const SizedBox.expand(
        child: Center(child: EmptyListWidget()),
      );
    }

    if (state.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => cubit.fetchList(refresh: true),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 180),
            EmptyListWidget(),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => cubit.fetchList(refresh: true),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p0,
          AppPadding.p16,
          AppPadding.p24,
        ),
        itemCount: state.items.length,
        separatorBuilder: (_, __) => Space.h16,
        itemBuilder: (context, index) {
          final item = state.items[index];
          final evaluationId = item.identity?.evaluationId;
          final serviceTypeValue = item.state?.serviceType;
          final hasValidServiceType = ServiceType.values.any(
            (serviceType) => serviceType.value == serviceTypeValue,
          );
          final canOpenPreInvoice =
              item.state?.customerPreInvoiceVisible == true &&
              evaluationId != null &&
              evaluationId > 0 &&
              hasValidServiceType;

          final itemServiceColor =
              ServiceType.fromValue(serviceTypeValue).serviceColor;

          return CustomerInvoiceSummaryCard(
            item: item,
            serviceColor: itemServiceColor,
            primaryActionTitle: 'پیش فاکتور',
            isPrimaryLoading:
                evaluationId != null &&
                state.previewLoadingEvaluationId == evaluationId,
            onPrimaryAction: canOpenPreInvoice
                ? () => _openInvoice(context, cubit, item)
                : null,
            onDetails: () => _openRequestDetails(context, cubit, item),
          );
        },
      ),
    );
  }

  Future<void> _listenState(
    BuildContext context,
    CustomerPreInvoiceCubit cubit,
    CustomerPreInvoiceState state,
  ) async {
    if (state.status == CustomerPreInvoiceViewStatus.connectionError) {
      await BottomSheetMessage.showCustom(
        context: context,
        content: NoInternetBottomSheet(
          onRetry: cubit.retryLastAction,
        ),
        actionWidget: const SizedBox.shrink(),
        isDismissible: false,
        enableDrag: false,
      );
      return;
    }

    final error = state.errorMessage;
    if (error != null && error.trim().isNotEmpty) {
      SnakeBarWidget.showError(
        context: context,
        message: error,
      );
    }

    final success = state.successMessage;
    if (success != null && success.trim().isNotEmpty) {
      SnakeBarWidget.showSuccess(
        context: context,
        message: success,
      );
    }
  }

  void _showFilter(
    BuildContext context,
    CustomerPreInvoiceCubit cubit,
    CustomerPreInvoiceState state,
  ) {
    showFilterBottomSheet<void>(
      context: context,
      builder: (_) => InvoiceFilterSheet(
        title: 'فیلتر پیش فاکتورهای مشتری',
        initialFilter: state.filter,
        categories: state.categories,
        allowAllServiceTypes: true,
        requireDateRange: true,
        showSubscriptionField: false,
        requestTrackCodeMaxLength: 9,
        agencyCodeMaxLength: 15,
        emdadgarNameMaxLength: 50,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }

  Future<void> _openInvoice(
    BuildContext context,
    CustomerPreInvoiceCubit cubit,
    InvoiceRecordEntity item,
  ) async {
    final result = await cubit.fetchPreInvoiceDetails(item);
    if (!context.mounted) return;

    await result.when<Future<void>>(
      success: (invoice, failures, resultCode) async {
        if (invoice == null) {
          SnakeBarWidget.showError(
            context: context,
            message: 'اطلاعات پیش فاکتور برای این درخواست یافت نشد.',
          );
          return;
        }

        final serviceType = ServiceType.fromValue(item.state?.serviceType);

        final finalized = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          builder: (_) => FractionallySizedBox(
            heightFactor: .96,
            child: CustomerPreInvoicePreviewSheet(
              invoice: invoice,
              serviceType: serviceType,
              onFinalize: (item.identity?.evaluationId ?? 0) > 0
                  ? () => _finalizeInvoice(context, cubit, item)
                  : null,
              onOpenDocument: invoice.invoiceGuid?.trim().isNotEmpty == true
                  ? () => _openCustomerInvoiceDocument(
                        context,
                        cubit,
                        invoice.invoiceGuid!,
                      )
                  : null,
            ),
          ),
        );

        if (finalized == true && context.mounted) {
          SnakeBarWidget.showSuccess(
            context: context,
            message: 'فاکتور مشتری با موفقیت نهایی سازی شد',
          );
          await cubit.fetchList(refresh: true);
        }
      },
      failure: (error, failures) async {
        SnakeBarWidget.showError(
          context: context,
          message: failures ?? 'دریافت پیش فاکتور با خطا مواجه شد.',
        );
      },
      expireToken: () async {
        SnakeBarWidget.showError(
          context: context,
          message: 'نشست کاربری منقضی شده است.',
        );
      },
      connectionError: () async {
        await BottomSheetMessage.showCustom(
          context: context,
          content: NoInternetBottomSheet(
            onRetry: () => _openInvoice(context, cubit, item),
          ),
          actionWidget: const SizedBox.shrink(),
          isDismissible: false,
          enableDrag: false,
        );
      },
    );
  }

  Future<bool> _finalizeInvoice(
    BuildContext context,
    CustomerPreInvoiceCubit cubit,
    InvoiceRecordEntity item,
  ) async {
    final result = await cubit.finalizePreInvoice(item);
    if (!context.mounted) return false;

    return result.when<bool>(
      success: (data, failures, resultCode) => true,
      failure: (error, failures) {
        SnakeBarWidget.showError(
          context: context,
          message: failures ?? 'نهایی سازی فاکتور با خطا مواجه شد.',
        );
        return false;
      },
      expireToken: () {
        SnakeBarWidget.showError(
          context: context,
          message: 'نشست کاربری منقضی شده است.',
        );
        return false;
      },
      connectionError: () {
        SnakeBarWidget.showError(
          context: context,
          message: 'اتصال به سرور برقرار نیست.',
        );
        return false;
      },
    );
  }

  Future<void> _openCustomerInvoiceDocument(
    BuildContext context,
    CustomerPreInvoiceCubit cubit,
    String invoiceGuid,
  ) async {
    final result = await cubit.getCustomerInvoiceDocumentUrls(invoiceGuid);
    if (!context.mounted) return;

    await result.when<Future<void>>(
      success: (urls, failures, resultCode) async {
        final rawUrl = urls.htmlViewUrl?.trim();
        final uri = rawUrl == null || rawUrl.isEmpty
            ? null
            : Uri.tryParse(rawUrl);

        if (uri == null || !await launchUrl(uri)) {
          if (!context.mounted) return;
          SnakeBarWidget.showError(
            context: context,
            message: 'لینک مشاهده فاکتور در دسترس نیست.',
          );
        }
      },
      failure: (error, failures) async {
        SnakeBarWidget.showError(
          context: context,
          message: failures ?? 'دریافت فایل فاکتور با خطا مواجه شد.',
        );
      },
      expireToken: () async {
        SnakeBarWidget.showError(
          context: context,
          message: 'نشست کاربری منقضی شده است.',
        );
      },
      connectionError: () async {
        SnakeBarWidget.showError(
          context: context,
          message: 'اتصال به سرور برقرار نیست.',
        );
      },
    );
  }

  Future<void> _openRequestDetails(
    BuildContext context,
    CustomerPreInvoiceCubit cubit,
    InvoiceRecordEntity item,
  ) async {
    final requestId = await cubit.cacheSelectedRequest(item);
    if (requestId == null || !context.mounted) return;

    await context.push(
      RequestDetailPage.path,
      extra: requestId,
    );
  }
}
