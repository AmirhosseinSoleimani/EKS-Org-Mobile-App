import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_status.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_state.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/pages/leave_details_page.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_list_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
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
      listener: (context, state) async {
        final message = state.lastMessage!;
        if (message.title.contains('خطا')) {
          await BottomSheetMessage.showError(
            context: context,
            data: message,
            isDismissible: true,
            enableDrag: true,
            onButtonTap: () => Navigator.of(context).pop(),
          );
          return;
        }
        await BottomSheetMessage.showNotice(
          context: context,
          data: message,
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
                              child: StatusFilterDropdown<LeaveStatus>(
                                value: state.selectedStatus,
                                options: LeaveCubit.statusOptions
                                    .map(
                                      (item) => StatusFilterOption(
                                        value: item.status,
                                        label: item.title,
                                      ),
                                    )
                                    .toList(),
                                onChanged: cubit.onStatusChanged,
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
                          onDelete: () => _confirmDelete(
                            context,
                            cubit,
                            item.id,
                          ),
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

  void _confirmDelete(
    BuildContext context,
    LeaveCubit cubit,
    int? id,
  ) {
    if (id == null) return;

    BottomSheetMessage.showCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<LeaveCubit, LeaveState>(
          builder: (sheetContext, state) {
            return DeleteConfirmSheet(
              title: 'حذف درخواست مرخصی',
              message: 'آیا از حذف این درخواست مرخصی مطمئن هستید؟',
              confirmTitle: 'حذف',
              isSubmitting: state.isActionLoading,
              onConfirm: () async {
                Navigator.of(sheetContext).pop();
                await cubit.deleteRequest(id);
              },
            );
          },
        ),
      ),
      actionWidget: const SizedBox.shrink(),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      maxHeight: 0.5,
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
          children: const [
            BodyMediumText(text: 'فیلترها'),
            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }
}
