import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/cubit/skills_certificates_cubit.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/widgets/skill_certificate_card.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/widgets/skills_certificates_bottom_sheets.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/widgets/skills_certificates_toolbar.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkillsCertificatesPage extends StatelessWidget {
  static const path = '/skills-certificates';
  static const name = 'skills-certificates';

  const SkillsCertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SkillsCertificatesCubit>()..init(),
      child: const _SkillsCertificatesView(),
    );
  }
}

class _SkillsCertificatesView extends StatelessWidget {
  const _SkillsCertificatesView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SkillsCertificatesCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<SkillsCertificatesCubit, SkillsCertificatesState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (_, message) {
              SnakeBarWidget.showError(
                context: context,
                message: message.message,
              );
            },
            loaded: (data) {
              final message = data.message;
              if (message == null || message.trim().isEmpty) return;
              SnakeBarWidget.showSuccess(context: context, message: message);
            },
            connectionError: (_) {
              BottomSheetMessage.showCustom(
                context: context,
                content: NoInternetBottomSheet(onRetry: cubit.fetchSkills),
                actionWidget: const SizedBox.shrink(),
                isDismissible: false,
                enableDrag: false,
              );
            },
          );
        },
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'گواهینامه مهارت'),
          floatingActionButton: FloatingActionButtonWidget(
            title: 'گواهینامه جدید',
            onPressed: () => SkillsCertificatesBottomSheets.showFormSheet(
              context: context,
              cubit: cubit,
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
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: BlocBuilder<SkillsCertificatesCubit,
                      SkillsCertificatesState>(
                    builder: (context, state) {
                      return SkillsCertificatesToolbar(
                        activeFilter: state.data.activeFilter,
                        isReportLoading: state.data.isReportLoading,
                        onFilterTap: () =>
                            SkillsCertificatesBottomSheets.showFilterSheet(
                          context: context,
                          cubit: cubit,
                        ),
                        onStatusChanged: cubit.changeActiveFilter,
                        onReportTap: cubit.exportReport,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SkillsCertificatesCubit,
                      SkillsCertificatesState>(
                    builder: (context, state) {
                      final data = state.data;

                      final hasConnectionError = state.maybeWhen(
                        connectionError: (_) => true,
                        orElse: () => false,
                      );

                      if (hasConnectionError && data.items.isEmpty) {
                        return const SizedBox.expand(
                          child: Center(child: EmptyListWidget()),
                        );
                      }

                      if (data.isInitialLoading && data.items.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final items = cubit.visibleItems;
                      if (items.isEmpty) {
                        return const Center(child: EmptyListWidget());
                      }

                      return RefreshIndicator(
                        onRefresh: cubit.fetchSkills,
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                            AppPadding.p16,
                            AppPadding.p4,
                            AppPadding.p16,
                            AppPadding.p32,
                          ),
                          itemCount: items.length + (data.hasMore ? 1 : 0),
                          separatorBuilder: (_, __) => Space.h12,
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              return Padding(
                                padding: const EdgeInsets.all(AppPadding.p16),
                                child: OutlinedButton.icon(
                                  onPressed: cubit.loadMore,
                                  icon: const Icon(Icons.expand_more),
                                  label: const BodyMediumText(text: 'نمایش موارد بیشتر'),
                                ),
                              );
                            }

                            final item = items[index];
                            return SkillCertificateCard(
                              item: item,
                              onLoadServices: () => cubit.loadServices(item),
                              onServicesLoaded: () =>
                                  SkillsCertificatesBottomSheets
                                      .showLoadedServicesSheet(
                                context: context,
                                cubit: cubit,
                              ),
                              onEdit: () =>
                                  SkillsCertificatesBottomSheets.showFormSheet(
                                context: context,
                                cubit: cubit,
                                skill: item,
                              ),
                              onDelete: () => _confirmDelete(
                                context: context,
                                cubit: cubit,
                                skill: item,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete({
    required BuildContext context,
    required SkillsCertificatesCubit cubit,
    required SkillCertificateEntity skill,
  }) {
    BottomSheetMessage.showCustom(
      context: context,
      content: DeleteConfirmSheet(
        title: 'حذف گواهی نامه ریزی',
        message: 'آیا مهارت ${skill.displayTitle} حذف شود؟',
        confirmTitle: 'حذف',
        onConfirm: () async {
          Navigator.of(context).pop();
          cubit.deleteSkill(skill);
        },
      ),
      actionWidget: SizedBox.shrink(),
    );
  }
}
