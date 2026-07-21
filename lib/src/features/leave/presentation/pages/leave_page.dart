import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_status.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_state.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/pages/leave_details_page.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_list_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LeavePage extends StatelessWidget {
  static const path = '/leave-page';
  static const name = 'leave-page';

  const LeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LeaveCubit>()..init(),
      child: const LeavePageView(),
    );
  }
}

class LeavePageView extends StatelessWidget {
  const LeavePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaveCubit, LeaveState>(
      listenWhen: (previous, current) {
        return previous.lastMessage != current.lastMessage &&
            current.lastMessage != null;
      },
      listener: (context, state) {
        BottomSheetMessage.showNotice(
          context: context,
          data: state.lastMessage!,
        );
      },
      builder: (context, state) {
        final cubit = context.read<LeaveCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF6F4F3),
          appBar: const SimpleAppBar(title: 'مرخصی ها'),
          body: RefreshIndicator(
            onRefresh: cubit.refresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _FilterButton(
                                onTap: () => _showFilters(context),
                              ),
                            ),
                            Space.w12,
                            Expanded(
                              child: _TopDropdown(
                                title: 'وضعیت',
                                value: state.selectedStatus,
                                items: LeaveCubit.statusOptions
                                    .map(
                                      (item) => DropdownMenuItem(
                                    value: item.status,
                                    child: Text(
                                        item.title,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    cubit.onStatusChanged(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isListLoading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.filteredItems.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text('مرخصی‌ای برای نمایش وجود ندارد.'),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    sliver: SliverList.builder(
                      itemCount: state.filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = state.filteredItems[index];
                        return LeaveListCard(
                          item: item,
                          onDetailsTap: () async {
                            final changed = await context.pushNamed<bool>(
                              LeaveDetailsPage.name,
                              extra: item.id,
                            );
                            if (changed == true && context.mounted) {
                              context.read<LeaveCubit>().refresh();
                            }
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<LeaveCubit>(),
          child: const LeaveFilterSheet(),
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyMediumText(text: 'فیلترها',),
            Icon(Icons.keyboard_arrow_down_rounded),

          ],
        ),
      ),
    );
  }
}

class _TopDropdown extends StatelessWidget {
  const _TopDropdown({
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final LeaveStatus value;
  final List<DropdownMenuItem<LeaveStatus>> items;
  final ValueChanged<LeaveStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LeaveStatus>(
          value: value,
          isExpanded: true,
          alignment: AlignmentDirectional.centerEnd,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items,
          onChanged: onChanged,
          hint: Text(title),
        ),
      ),
    );
  }
}

