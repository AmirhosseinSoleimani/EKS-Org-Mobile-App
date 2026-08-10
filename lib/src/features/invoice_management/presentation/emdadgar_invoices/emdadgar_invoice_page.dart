import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/enums/emdadgar_invoice_stage.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoices/cubit/emdadgar_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/policies/current_session_access_policy.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/presentation/widgets/current_session_access_builder.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/emdadgar_invoice_header.dart';
import 'widgets/emdadgar_invoice_list.dart';
import 'widgets/emdadgar_invoice_confirmation_sheet.dart';
import 'widgets/emdadgar_invoice_operations_sheet.dart';
import 'widgets/emdadgar_selected_items_bar.dart';

class EmdadgarInvoicePage extends StatelessWidget {
  const EmdadgarInvoicePage({
    super.key,
    this.initialStage = EmdadgarInvoiceStage.initial,
  });

  final EmdadgarInvoiceStage initialStage;

  static const String path = '/emdadgar-invoices';
  static const String name = 'emdadgar-invoices';

  @override
  Widget build(BuildContext context) {
    return CurrentSessionAccessBuilder(
      emptyBuilder: (_) => const _InvoiceAccessDeniedView(),
      builder: (context, access) {
        final availableStages = _availableStages(access);
        if (availableStages.isEmpty) {
          return const _InvoiceAccessDeniedView();
        }

        final resolvedInitialStage = availableStages.contains(initialStage)
            ? initialStage
            : availableStages.first;

        return BlocProvider(
          create: (_) => getIt<EmdadgarInvoiceCubit>()
            ..initialize(initialStage: resolvedInitialStage),
          child: _EmdadgarInvoiceView(availableStages: availableStages),
        );
      },
    );
  }

  List<EmdadgarInvoiceStage> _availableStages(
    CurrentSessionAccessPolicy access,
  ) {
    return [
      if (access.canShowEmdadgarPreInvoiceMenu())
        EmdadgarInvoiceStage.initial,
      if (access.canShowEmdadgarInvoiceMenu())
        EmdadgarInvoiceStage.current,
      if (access.canShowEmdadgarAmaliatFinalInvoiceMenu())
        EmdadgarInvoiceStage.finalApproval,
      if (access.canShowEmdadgarFinalInvoiceMenu())
        EmdadgarInvoiceStage.finalCorrection,
      if (access.canShowEmdadgarDefiniteInvoiceMenu())
        EmdadgarInvoiceStage.taxpayerFinal,
    ];
  }
}

class _InvoiceAccessDeniedView extends StatelessWidget {
  const _InvoiceAccessDeniedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'صورت وضعیت ها'),
      body: Center(
        child: Text(
          'شما دسترسی لازم برای مشاهده صورت وضعیت‌ها را ندارید.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _EmdadgarInvoiceView extends StatefulWidget {
  const _EmdadgarInvoiceView({required this.availableStages});

  final List<EmdadgarInvoiceStage> availableStages;

  @override
  State<_EmdadgarInvoiceView> createState() => _EmdadgarInvoiceViewState();
}

class _EmdadgarInvoiceViewState extends State<_EmdadgarInvoiceView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadgarInvoiceCubit>();
    final theme = Theme.of(context);

    return BlocListener<
      EmdadgarInvoiceCubit,
      EmdadgarInvoiceState
    >(
      listener: (context, state) => _listenState(context, cubit, state),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'صورت وضعیت ها'),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: const {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child:
              BlocBuilder<
                EmdadgarInvoiceCubit,
                EmdadgarInvoiceState
              >(
                builder: (context, state) {
                  return state.when(
                    idle: () => const SizedBox.shrink(),
                    loading: () => cubit.hasLoadedOnce
                        ? _buildContent(context, cubit, listLoading: true)
                        : const Center(child: CircularProgressIndicator()),
                    loaded: () => _buildContent(context, cubit),
                    error: (_) => _buildContent(context, cubit),
                    connectionError: () => _buildContent(context, cubit),
                  );
                },
              ),
        ),
        bottomNavigationBar: EmdadgarSelectedItemsBar(
          cubit: cubit,
          onConfirmTap: () => _showConfirmation(context, cubit),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    EmdadgarInvoiceCubit cubit, {
    bool listLoading = false,
  }) {
    return Column(
      children: [
        EmdadgarInvoiceHeader(
          cubit: cubit,
          availableStages: widget.availableStages,
          onFilterTap: () => _showFilter(context, cubit),
        ),
        Expanded(
          child: listLoading
              ? const Center(child: CircularProgressIndicator())
              : EmdadgarInvoiceList(
                  cubit: cubit,
                  scrollController: _scrollController,
                  onInvoiceTap: (item) => _openInvoice(context, cubit, item),
                  onOperationsTap: (item) =>
                      _showOperations(context, cubit, item),
                ),
        ),
      ],
    );
  }

  void _listenState(
    BuildContext context,
    EmdadgarInvoiceCubit cubit,
    EmdadgarInvoiceState state,
  ) {
    state.whenOrNull(
      error: (message) {
        BottomSheetMessage.showErrorWithAction(
          context: context,
          data: message,
          onPositive: () {
            context.pop();
            cubit.retryLastAction();
          },
        );
      },
      connectionError: () {
        BottomSheetMessage.showCustom(
          context: context,
          content: NoInternetBottomSheet(onRetry: cubit.retryLastAction),
          actionWidget: const SizedBox.shrink(),
          isDismissible: false,
          enableDrag: false,
        );
      },
      loaded: () {
        final message = cubit.consumeSuccessMessage();
        if (message == null || !context.mounted) return;
        SnakeBarWidget.showSuccess(context: context, message: message);
      },
    );
  }

  void _showFilter(BuildContext context, EmdadgarInvoiceCubit cubit) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => InvoiceFilterSheet(
        title: 'فیلتر صورت وضعیت ها',
        showSubscriptionField: false,
        initialFilter: cubit.filter,
        categories: cubit.categories,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }

  Future<void> _openInvoice(
    BuildContext context,
    EmdadgarInvoiceCubit cubit,
    EmdadgarInvoiceRecordEntity item,
  ) async {
    print("onEvaluationClicked....");
    final id = await cubit.cacheSelectedRequest(item);
    if (id == null || !context.mounted) return;
    await context.push(EmdadgarInvoicePage.path);
  }

  Future<void> _showOperations(
    BuildContext context,
    EmdadgarInvoiceCubit cubit,
    EmdadgarInvoiceRecordEntity item,
  ) async {
    await BottomSheetMessage.showCustom(
      context: context,
      maxHeight: .32,
      content: EmdadgarInvoiceOperationsSheet(
        correctionEnabled: false,
        onDetailsTap: () {
          Navigator.of(context).pop();
          _openRequestDetails(context, cubit, item);
        },
        onCorrectionTap: () {},
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  Future<void> _openRequestDetails(
    BuildContext context,
    EmdadgarInvoiceCubit cubit,
    EmdadgarInvoiceRecordEntity item,
  ) async {
    final id = await cubit.cacheSelectedRequest(item);
    if (id == null || !context.mounted) return;
    await context.push(RequestDetailPage.path, extra: id);
  }

  Future<void> _showConfirmation(
    BuildContext context,
    EmdadgarInvoiceCubit cubit,
  ) {
    return BottomSheetMessage.showCustom(
      context: context,
      maxHeight: .52,
      content: EmdadgarInvoiceConfirmationSheet(
        onConfirm: () {
          Navigator.of(context).pop();
          cubit.confirmSelected();
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final cubit = context.read<EmdadgarInvoiceCubit>();
    final reachedBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - AppSize.s120;

    if (reachedBottom &&
        cubit.hasMore &&
        !cubit.paginationLoadingNotifier.value) {
      cubit.fetchList();
    }
  }
}
