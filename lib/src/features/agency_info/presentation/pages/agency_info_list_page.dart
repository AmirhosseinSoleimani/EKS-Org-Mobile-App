import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/add_agency_info_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_info_details_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_delete_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_detail_sheet.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_report_button.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AgencyInfoListPage extends StatelessWidget {
  static const path = '/agency-info-list-page';
  static const name = 'agency-info-list-page';

  const AgencyInfoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AgencyInfoCubit>()..fetchList(refresh: true),
      child: const _AgencyInfoListView(),
    );
  }
}

class _AgencyInfoListView extends StatefulWidget {
  const _AgencyInfoListView();

  @override
  State<_AgencyInfoListView> createState() => _AgencyInfoListViewState();
}

class _AgencyInfoListViewState extends State<_AgencyInfoListView> {
  final _scrollController = ScrollController();

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
    final cubit = context.read<AgencyInfoCubit>();
    final theme = Theme.of(context);

    return BlocListener<AgencyInfoCubit, AgencyInfoState>(
      listener: (context, state) {
        final data = state.data;
        final errorMessage = data.errorMessage;
        final successMessage = data.successMessage;

        if (state.status == AgencyInfoViewStatus.connectionError) {
          BottomSheetMessage.showCustom(
            context: context,
            content: NoInternetBottomSheet(onRetry: cubit.retryLastAction),
            actionWidget: const SizedBox.shrink(),
            isDismissible: false,
            enableDrag: false,
          );
        } else if (errorMessage != null && errorMessage.isNotEmpty) {
          SnakeBarWidget.showError(context: context, message: errorMessage);
        } else if (successMessage != null && successMessage.isNotEmpty) {
          SnakeBarWidget.showSuccess(context: context, message: successMessage);
        }

        if (state.status == AgencyInfoViewStatus.actionDataLoaded &&
            data.actionType != null &&
            data.actionAgency != null) {
          final actionType = data.actionType!;
          final item = data.actionAgency!;
          final actionData = data.actionData;
          cubit.clearActionData();
          BottomSheetMessage.showFullScreenCustom<void>(
            context: context,
            content: AgencyInfoActionDetailSheet(
              actionType: actionType,
              item: item,
              actionData: actionData,
            ),
            backgroundColor: theme.colorScheme.surface,
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'نمایندگی‌ها'),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: FloatingActionButtonWidget(
            title: 'نمایندگی جدید',
            onPressed: () async {
              final changed = await context.pushNamed<bool>(
                AddAgencyInfoPage.name,
              );
              if (changed == true && context.mounted) {
                cubit.fetchList(refresh: true);
                SnakeBarWidget.showSuccess(
                  context: context,
                  message: 'نمایندگی با موفقیت ثبت شد.',
                );
              }
            },
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p8,
                ),
                child: BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
                  buildWhen: (previous, current) =>
                  previous.data.filter != current.data.filter,
                  builder: (context, state) {
                    return FiltersRow(
                      filters: [
                        FilterButton(
                          title: 'فیلترها',
                          icon: Icons.filter_alt_outlined,
                          onTap: () => _showFilter(context, cubit),
                        ),
                        SizedBox(
                          width: AppSize.s120,
                          child: EkDropDown(
                            const ['همه', 'فعال', 'غیرفعال'],
                            label: 'وضعیت',
                            selectedItem:
                                _statusDropDownTitle(state.data.filter.isActive),
                            onItemValue: (value) => _applyStatusFilter(
                              cubit,
                              state.data.filter,
                              value,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p18,
                  horizontal: AppPadding.p16,),
                child: BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
                  buildWhen: (previous, current) =>
                  previous.data.isReportLoading != current.data.isReportLoading,
                  builder: (context, state) {
                    return AgencyInfoReportButton(
                      isLoading: state.data.isReportLoading,
                      onTap: cubit.getReport,
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
                  builder: (context, state) {
                    return _buildContent(context, cubit, state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context,
      AgencyInfoCubit cubit,
      AgencyInfoState state,) {
    final data = state.data;

    if (data.isInitialLoading && data.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == AgencyInfoViewStatus.connectionError &&
        data.items.isEmpty) {
      return _MessageState(
        title: 'اتصال به اینترنت برقرار نیست',
        actionTitle: 'تلاش مجدد',
        onAction: cubit.retryLastAction,
      );
    }

    if ((state.status == AgencyInfoViewStatus.pageError ||
        state.status == AgencyInfoViewStatus.actionError) &&
        data.items.isEmpty) {
      return _MessageState(
        title: data.errorMessage ?? 'عملیات با خطا مواجه شد.',
        actionTitle: 'تلاش مجدد',
        onAction: cubit.retryLastAction,
      );
    }

    if (data.items.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: () => cubit.fetchList(refresh: true),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: constraints.maxHeight,
                  child: const Center(child: EmptyListWidget()),
                ),
              ],
            ),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () => cubit.fetchList(refresh: true),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p8,
          AppPadding.p16,
          AppPadding.p100,
        ),
        itemCount: data.items.length + (data.isPaginationLoading ? 1 : 0),
        separatorBuilder: (_, __) => Space.h12,
        itemBuilder: (context, index) {
          if (index >= data.items.length) {
            return const Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final item = data.items[index];
          return AgencyInfoSummaryCard(
            item: item,
            onTap: () {}, //=> _openDetails(context, item),
            onAction: () => _showActionSheet(context, cubit, item),
          );
        },
      ),
    );
  }

  Future<void> _openDetails(BuildContext context, AgencyInfoEntity item) async {
    final changed = await context.pushNamed(
      AgencyInfoDetailsPage.name,
      extra: item.id,
    );
    if (changed == true && context.mounted) {
      context.read<AgencyInfoCubit>().fetchList(refresh: true);
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final data = context.read<AgencyInfoCubit>().state.data;
    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - AppSize.s120;

    if (reachedBottom && data.hasMore && !data.isPaginationLoading) {
      context.read<AgencyInfoCubit>().fetchList();
    }
  }

  void _showFilter(BuildContext context, AgencyInfoCubit cubit) {
    BottomSheetMessage.showCustom(
      context: context,
      content: AgencyInfoFilterSheet(
        initialFilter: cubit.state.data.filter,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
      actionWidget: const SizedBox.shrink(),
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .onPrimary,
      maxHeight: 0.9,
    );
  }

  void _showActionSheet(
    BuildContext context,
    AgencyInfoCubit cubit,
    AgencyInfoEntity item,
  ) {
    BottomSheetMessage.showCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
          builder: (context, state) {
            final currentItem = _resolveActionAgency(state, item);

            return AgencyInfoActionSheet(
              loadingActionType: state.data.loadingDetailId == currentItem.id
                  ? state.data.actionType
                  : null,
              isActive: currentItem.isActive,
              onActionSelected: (actionType) => _handleActionSelected(
                context,
                cubit,
                currentItem,
                actionType,
              ),
            );
          },
        ),
      ),
      actionWidget: const SizedBox.shrink(),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  Future<void> _handleActionSelected(
    BuildContext context,
    AgencyInfoCubit cubit,
    AgencyInfoEntity item,
    AgencyInfoActionType actionType,
  ) async {
    if (actionType == AgencyInfoActionType.delete) {
      Navigator.of(context).pop();
      await Future<void>.delayed(Duration.zero);
      if (!mounted) return;
      _showDeleteConfirmation(this.context, cubit, item);
      return;
    }

    await cubit.loadActionData(actionType, item);
  }

  void _showDeleteConfirmation(
    BuildContext context,
    AgencyInfoCubit cubit,
    AgencyInfoEntity item,
  ) {
    BottomSheetMessage.showCustom(
      context: context,
      content: AgencyInfoDeleteActionView(
        item: item,
        cubit: cubit,
      ),
      actionWidget: const SizedBox.shrink(),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      maxHeight: 0.45,
    );
  }

  AgencyInfoEntity _resolveActionAgency(
    AgencyInfoState state,
    AgencyInfoEntity fallback,
  ) {
    for (final agency in state.data.items) {
      if (agency.id == fallback.id) return agency;
    }

    final actionAgency = state.data.actionAgency;
    if (actionAgency?.id == fallback.id) return actionAgency!;

    return fallback;
  }

  void _applyStatusFilter(
    AgencyInfoCubit cubit,
    AgencyInfoFilterParamEntity filter,
    String value,
  ) {
    if (value == 'فعال') {
      cubit.applyFilter(filter.copyWith(isActive: true, skip: 0));
      return;
    }

    if (value == 'غیرفعال') {
      cubit.applyFilter(filter.copyWith(isActive: false, skip: 0));
      return;
    }

    cubit.applyFilter(filter.copyWith(clearIsActive: true, skip: 0));
  }

  String _statusDropDownTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return 'همه';
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.title,
    required this.actionTitle,
    required this.onAction,
  });

  final String title;
  final String actionTitle;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyListWidget(),
            Space.h16,
            BodyMediumText(text: title),
            Space.h16,
            OutlinedButton(
              onPressed: onAction,
              child: BodyMediumText(text: actionTitle),
            ),
          ],
        ),
      ),
    );
  }
}
