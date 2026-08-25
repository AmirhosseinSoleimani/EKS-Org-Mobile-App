import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/customer_invoice_summary_card.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_list_section_header.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_invoices/cubit/customer_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/invoice_request_context_loader.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/pages/invoice_page.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerInvoicePage extends StatelessWidget {
  const CustomerInvoicePage({super.key});

  static const String path = '/customer-invoices';
  static const String name = 'customer-invoices';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CustomerInvoiceCubit>()..initialize(),
      child: const _CustomerInvoiceView(),
    );
  }
}

class _CustomerInvoiceView extends StatefulWidget {
  const _CustomerInvoiceView();

  @override
  State<_CustomerInvoiceView> createState() =>
      _CustomerInvoiceViewState();
}

class _CustomerInvoiceViewState extends State<_CustomerInvoiceView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CustomerInvoiceCubit>();
    final theme = Theme.of(context);

    return BlocListener<CustomerInvoiceCubit, CustomerInvoiceState>(
      listener: (context, state) => _listenState(context, cubit, state),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'فاکتورهای مشتری'),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: const {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: BlocBuilder<CustomerInvoiceCubit, CustomerInvoiceState>(
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
                        FiltersRow(
                          filters: [
                            FilterButton(
                              title: 'فیلترها',
                              onTap: () => _showFilter(
                                context,
                                cubit,
                                state,
                              ),
                            ),
                          ],
                        ),
                        Space.h16,
                        ReportButtonWidget(
                          isLoading: state.isReportLoading,
                          onTap: cubit.exportReport,
                        ),
                        Space.h24,
                        InvoiceListSectionHeader(
                          title: 'فاکتورهای فعلی',
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
    CustomerInvoiceCubit cubit,
    CustomerInvoiceState state,
    Color serviceColor,
  ) {
    if (state.isInitialLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if ((state.status == CustomerInvoiceViewStatus.error ||
            state.status == CustomerInvoiceViewStatus.connectionError) &&
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
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p0,
          AppPadding.p16,
          AppPadding.p24,
        ),
        itemCount: state.items.length + (state.isPaginationLoading ? 1 : 0),
        separatorBuilder: (_, __) => Space.h16,
        itemBuilder: (context, index) {
          if (index >= state.items.length) {
            return const Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final item = state.items[index];

          final evaluationId = item.identity?.evaluationId;
          final canOpenInvoice = item.state?.customerInvoiceVisible == true &&
              evaluationId != null &&
              evaluationId > 0;

          return CustomerInvoiceSummaryCard(
            item: item,
            serviceColor: serviceColor,
            primaryActionTitle: 'مشاهده فاکتور',
            onPrimaryAction: canOpenInvoice
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
    CustomerInvoiceCubit cubit,
    CustomerInvoiceState state,
  ) async {
    if (state.status == CustomerInvoiceViewStatus.connectionError) {
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
    CustomerInvoiceCubit cubit,
    CustomerInvoiceState state,
  ) {
    showFilterBottomSheet<void>(
      context: context,
      builder: (_) => InvoiceFilterSheet(
        title: 'فیلتر فاکتورهای مشتری',
        initialFilter: state.filter,
        categories: state.categories,
        allowAllServiceTypes: true,
        requireDateRange: true,
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
    CustomerInvoiceCubit cubit,
    InvoiceRecordEntity item,
  ) async {
    final evaluationId = item.identity?.evaluationId;
    if (evaluationId == null || evaluationId <= 0) {
      SnakeBarWidget.showError(
        context: context,
        message: 'شناسه ارزیابی برای دریافت فاکتور موجود نیست.',
      );
      return;
    }

    final serviceType = ServiceType.fromValue(item.state?.serviceType);
    final requestContext = InvoiceRequestContext(
      requestId: item.identity?.serviceRequestId,
      serviceType: serviceType,
      isGuaranty: item.state?.isGaranty == true,
      isSubscription: item.state?.subscription == true,
    );

    await context.push(
      InvoicePage.path,
      extra: InvoicePageArgs(
        invoiceType: InvoiceType.invoice,
        emdadgarEvaluationId: evaluationId,
        initialRequestContext: requestContext,
        onOpenDocument: (invoiceContext, invoiceGuid) =>
            _openCustomerInvoiceDocument(
          invoiceContext,
          cubit,
          invoiceGuid,
        ),
      ),
    );
  }

  Future<void> _openCustomerInvoiceDocument(
    BuildContext context,
    CustomerInvoiceCubit cubit,
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
    CustomerInvoiceCubit cubit,
    InvoiceRecordEntity item,
  ) async {
    final requestId = await cubit.cacheSelectedRequest(item);
    if (requestId == null || !context.mounted) return;

    await context.push(
      RequestDetailPage.path,
      extra: requestId,
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final cubit = context.read<CustomerInvoiceCubit>();
    final state = cubit.state;

    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - AppSize.s120;

    if (reachedBottom &&
        state.hasMore &&
        !state.isPaginationLoading &&
        !state.isInitialLoading) {
      cubit.fetchList();
    }
  }
}
