import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/detail/rescuer_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/detail/rescuer_contact_info_section.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/detail/rescuer_history_section.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/detail/rescuer_personal_info_section.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/detail/rescuer_profile_header.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/detail/rescuer_skill_certificates_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RescuerDetailPage extends StatelessWidget {
  static const path = '/rescuer-details';
  static const name = 'rescuer-details';

  final int rescuerId;

  const RescuerDetailPage({
    super.key,
    required this.rescuerId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RescuerDetailCubit>()..loadDetails(rescuerId),
      child: const _RescuerDetailView(),
    );
  }
}

class _RescuerDetailView extends StatelessWidget {
  const _RescuerDetailView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RescuerDetailCubit>();

    return BlocListener<RescuerDetailCubit, RescuerDetailState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (data, message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.retryLastAction,
            );
          },
          actionError: (data, message) {
            SnakeBarWidget.showError(
              context: context,
              message: message,
            );
          },
          connectionError: (data) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.retryLastAction,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'جزئیات امدادرسان'),
        body: BlocBuilder<RescuerDetailCubit, RescuerDetailState>(
          builder: (context, state) {
            return state.maybeWhen(
              idle: (_) => const SizedBox.shrink(),
              loading: (_) => const LoadingWidget(),
              loaded: (_) => _buildContent(context, cubit),
              actionLoading: (_) => _buildContent(context, cubit),
              orElse: () => _buildContent(context, cubit),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RescuerDetailCubit cubit) {
    final item = cubit.rescuer;
    if (item == null) return const SizedBox.shrink();

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  RescuerProfileHeader(item: item),
                  const SizedBox(height: 12),
                  RescuerPersonalInfoSection(item: item),
                  RescuerContactInfoSection(item: item),
                  RescuerSkillCertificatesSection(
                    items: cubit.skillCertificates,
                  ),
                  RescuerHistorySection(items: cubit.histories),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: InkwellButtonWidget(
              title: 'حذف امدادرسان',
              backgroundColor: Theme.of(context).colorScheme.error,
              showLoading: cubit.isDeleting,
              prefixIcon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.onError,
              ),
              onTap: cubit.isDeleting
                  ? null
                  : () => _confirmDelete(context, cubit),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, RescuerDetailCubit cubit) {
    BottomSheetMessage.showNoticeWithAction(
      context: context,
      data: const BottomSheetMessageModel(
        title: 'حذف امدادرسان',
        message: 'آیا از حذف این امدادرسان مطمئن هستید؟',
      ),
      positiveText: 'حذف',
      cancelTxt: 'انصراف',
      buttonColor: Theme.of(context).colorScheme.error,
      onPositive: () async {
        context.pop();
        final deleted = await cubit.deleteRescuer();
        if (!context.mounted || !deleted) return;
        Navigator.of(context).pop(true);
      },
    );
  }
}
