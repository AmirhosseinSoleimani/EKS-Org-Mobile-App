import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_info_details_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
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

    return BlocListener<AgencyInfoCubit, AgencyInfoState>(
      listener: (context, state) {
        final message = state.data.errorMessage;
        if (message != null && message.isNotEmpty) {
          SnakeBarWidget.showError(context: context, message: message);
        }
      },
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'نمایندگی ها'),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showFilter(context, cubit),
          child: const Icon(Icons.filter_alt_outlined),
        ),
        body: BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
          builder: (context, state) {
            final data = state.data;
            if (data.isInitialLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (data.items.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => cubit.fetchList(refresh: true),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: AppSize.s180),
                    Center(child: EmptyListWidget()),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => cubit.fetchList(refresh: true),
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppPadding.p16),
                itemCount: data.items.length + (data.isPaginationLoading ? 1 : 0),
                separatorBuilder: (_, __) => Space.h12,
                itemBuilder: (context, index) {
                  if (index >= data.items.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final item = data.items[index];
                  return AgencyInfoSummaryCard(
                    item: item,
                    onTap: () async {
                      final changed = await context.pushNamed(
                        AgencyInfoDetailsPage.name,
                        extra: item.id,
                      );
                      if (changed == true && context.mounted) {
                        context.read<AgencyInfoCubit>().fetchList(refresh: true);
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final data = context.read<AgencyInfoCubit>().state.data;
    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - AppSize.s120;

    if (reachedBottom && data.hasMore && !data.isPaginationLoading) {
      context.read<AgencyInfoCubit>().fetchList();
    }
  }

  void _showFilter(BuildContext context, AgencyInfoCubit cubit) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => AgencyInfoFilterSheet(
        initialFilter: cubit.state.data.filter,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }
}
