import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/use_cases/get_invoice_agency_objections_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/cubit/invoice_agency_objection_cubit.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/widgets/invoice_agency_objection_card.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/widgets/invoice_agency_objection_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/widgets/invoice_agency_objection_header.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AgencyCorrectionRequestsPage extends StatelessWidget {
  const AgencyCorrectionRequestsPage({super.key});

  static const String path = '/agency-correction-requests';
  static const String name = 'agency-correction-requests';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvoiceAgencyObjectionCubit(
        getIt<GetInvoiceAgencyObjectionsUseCase>(),
        getIt<ExportExcelUseCase>(),
        getIt<SetSelectedRequestItemUseCase>(),
      )..initialize(),
      child: const _AgencyCorrectionRequestsView(),
    );
  }
}

class _AgencyCorrectionRequestsView extends StatefulWidget {
  const _AgencyCorrectionRequestsView();

  @override
  State<_AgencyCorrectionRequestsView> createState() =>
      _AgencyCorrectionRequestsViewState();
}

class _AgencyCorrectionRequestsViewState
    extends State<_AgencyCorrectionRequestsView> {
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
    final cubit = context.read<InvoiceAgencyObjectionCubit>();
    final theme = Theme.of(context);

    return BlocListener<InvoiceAgencyObjectionCubit, InvoiceAgencyObjectionState>(
      listener: (context, state) => _listenState(context, cubit, state),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'درخواست‌های اصلاحی (نماینده)'),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: const {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: BlocBuilder<
            InvoiceAgencyObjectionCubit,
            InvoiceAgencyObjectionState
          >(
            builder: (context, state) {
              return state.when(
                idle: () => const SizedBox.shrink(),
                loading: () => cubit.hasLoadedOnce
                    ? _buildContent(context, cubit, listLoading: true)
                    : const Center(child: CircularProgressIndicator()),
                loaded: () => _buildContent(context, cubit),
                error: (_) => cubit.itemsNotifier.value.isEmpty
                    ? const SizedBox.expand(
                        child: Center(child: EmptyListWidget()),
                      )
                    : _buildContent(context, cubit),
                connectionError: () => cubit.itemsNotifier.value.isEmpty
                    ? const SizedBox.expand(
                        child: Center(child: EmptyListWidget()),
                      )
                    : _buildContent(context, cubit),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    InvoiceAgencyObjectionCubit cubit, {
    bool listLoading = false,
  }) {
    return Column(
      children: [
        InvoiceAgencyObjectionHeader(
          cubit: cubit,
          onFilterTap: () => _showFilter(context, cubit),
        ),
        Expanded(
          child: listLoading
              ? const Center(child: CircularProgressIndicator())
              : ValueListenableBuilder<List<InvoiceAgencyObjectionEntity>>(
                  valueListenable: cubit.itemsNotifier,
                  builder: (_, items, __) => _buildList(
                    context,
                    cubit,
                    items,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildList(
    BuildContext context,
    InvoiceAgencyObjectionCubit cubit,
    List<InvoiceAgencyObjectionEntity> items,
  ) {
    if (items.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => cubit.fetchList(refresh: true),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: AppSize.s150),
            EmptyListWidget(),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => cubit.fetchList(refresh: true),
      child: ValueListenableBuilder<bool>(
        valueListenable: cubit.paginationLoadingNotifier,
        builder: (_, isPaginationLoading, __) => ListView.separated(
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
          itemCount: items.length + (isPaginationLoading ? 1 : 0),
          separatorBuilder: (_, __) => Space.h16,
          itemBuilder: (context, index) {
            if (index >= items.length) {
              return const Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final item = items[index];
            return InvoiceAgencyObjectionCard(
              item: item,
              onDetailsTap: () => _openRequestDetails(context, cubit, item),
            );
          },
        ),
      ),
    );
  }

  void _listenState(
    BuildContext context,
    InvoiceAgencyObjectionCubit cubit,
    InvoiceAgencyObjectionState state,
  ) {
    state.whenOrNull(
      error: (message) {
        BottomSheetMessage.showErrorWithAction(
          context: context,
          data: message,
          onPositive: () {
            Navigator.of(context).pop();
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

  void _showFilter(
    BuildContext context,
    InvoiceAgencyObjectionCubit cubit,
  ) {
    showFilterBottomSheet<void>(
      context: context,
      builder: (_) => InvoiceAgencyObjectionFilterSheet(
        initialFilter: cubit.filter,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }

  Future<void> _openRequestDetails(
    BuildContext context,
    InvoiceAgencyObjectionCubit cubit,
    InvoiceAgencyObjectionEntity item,
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

    final cubit = context.read<InvoiceAgencyObjectionCubit>();
    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - AppSize.s120;

    if (reachedBottom &&
        cubit.hasMore &&
        !cubit.paginationLoadingNotifier.value) {
      cubit.fetchList();
    }
  }
}
