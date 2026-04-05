import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/active_request/cubit/active_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/active_request/cubit/active_request_state.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/active_request/widget/active_request_item_widget.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/active_request/widget/active_request_shimmer_widget.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/cubit/request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/request_history_button.dart';

class ActiveRequestPage extends StatefulWidget {
  static const name = 'active-request-name';
  static const path = '/active-request-page';

  const ActiveRequestPage({super.key});

  @override
  State<ActiveRequestPage> createState() => _ActiveRequestPageState();
}

class _ActiveRequestPageState extends State<ActiveRequestPage> with RouteAware{

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActiveRequestCubit>(
      create: (_) => getIt<ActiveRequestCubit>()..init(),
      child: Builder(
        builder: (ctx) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            ctx.read<ActiveRequestCubit>().init();
          });
          return const _ActiveRequestView();
        }
      ),
    );
  }
}

class _ActiveRequestView extends StatelessWidget {
  const _ActiveRequestView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActiveRequestCubit, ActiveRequestState>(
      listenWhen: (previous, current) => current.maybeWhen(
        error: (_) => true,
        orElse: () => false,
        connectionError: () => true,
      ),
      listener: (context, state) {
        state.whenOrNull(
          error: (bottomSheetMessage) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: bottomSheetMessage,
              onPositive: context.read<RequestListCubit>().init,
            );
          },
          connectionError: () {
            final cubit = context.read<ActiveRequestCubit>();
            BottomSheetMessage.showCustom(
                context: context,
                content: NoInternetBottomSheet(
                    onRetry: cubit.init),
                actionWidget: const SizedBox.shrink(), isDismissible: false,enableDrag: false);
          },
        );
      },
      child: BlocBuilder<ActiveRequestCubit, ActiveRequestState>(
        buildWhen: (previous, current) => current.maybeWhen(
          success: () => true,
          idle: () => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const ActiveRequestShimmerWidget(),
            orElse: () => const _ActiveRequestContent(),
          );
        },
      ),
    );
  }

}

class _ActiveRequestContent extends StatelessWidget {
  const _ActiveRequestContent();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActiveRequestCubit>();
    final activeRequestList = cubit.activeRequestList;
    if (activeRequestList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: _EmptyList(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            const TitleLargeText(text: 'درخواست های فعال'),
            Space.h12,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activeRequestList.length,
              separatorBuilder: (_, index) => Space.h16,
              itemBuilder: (_, index) {
                return ActiveRequestItemWidget(
                  item: activeRequestList[index],
                  themeColor: (activeRequestList[index]?.type ==
                          RequestType.homeService.value)
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                );
              },
            ),
            Space.h16,
            const RequestHistoryButton(),
          ],
        ),
      );
    }
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SvgWidget(
          src: SvgAsset(SvgManager.emptyList),
        ),
        Space.h16,
        TitleLargeText(
          text: 'هیچ موردی جهت نمایش وجود ندارد',
          color: Theme.of(context).colorScheme.onPrimaryFixed,
          fontSize: AppSize.s16,
        ),
        Space.h24,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p38),
          child: RequestHistoryButton(),
        ),
      ],
    );
  }
}
