import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_status.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_cubit.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/cubit/leave_state.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_action_dialogs.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/widgets/leave_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LeaveDetailsPage extends StatelessWidget {
  static const path = '/leave-details-page';
  static const name = 'leave-details-page';

  const LeaveDetailsPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LeaveCubit>()..getDetails(id),
      child: LeaveDetailsPageView(id: id),
    );
  }
}

class LeaveDetailsPageView extends StatelessWidget {
  const LeaveDetailsPageView({
    super.key,
    required this.id,
  });

  final int id;

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
        } else {
          await BottomSheetMessage.showNotice(
            context: context,
            data: message,
          );
        }
        if (state.actionCompleted && context.mounted) {
          context.pop(true);
        }
      },
      builder: (context, state) {
        final details = state.details;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F5),
          appBar: const SimpleAppBar(title: 'جزئیات مرخصی'),
          body: state.isDetailsLoading
              ? const Center(child: CircularProgressIndicator())
              : details == null
                  ?  const Center(child: EmptyListWidget())
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _CollapsedInfoTile(
                                  title: 'اطلاعات نمایندگی',
                                  summary: details.agencyName,
                                  children: [
                                    _InfoRow(
                                      label: 'کد نمایندگی',
                                      value: details.agencyCode,
                                    ),
                                    _InfoRow(
                                      label: 'نام نمایندگی',
                                      value: details.agencyName,
                                    ),
                                    _InfoRow(
                                      label: 'نام مدیر',
                                      value: details.agencyManagerFullName,
                                    ),
                                    _InfoRow(
                                      label: 'شماره موبایل',
                                      value: details.agencyMobile,
                                      ltr: true,
                                    ),
                                    _InfoRow(
                                      label: 'استان',
                                      value: details.agencyProvince,
                                    ),
                                    _InfoRow(
                                      label: 'شهر',
                                      value: details.agencyCity,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: AppPadding.p12),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'آدرس',
                                            textAlign: TextAlign.right,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: const Color(0xFF555555),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Space.w12,
                                          Expanded(
                                            child: Text(
                                              _text(details.agencyAddress),
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: const Color(0xFF1F1F1F),
                                                    fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                _CollapsedInfoTile(
                                  title: 'اطلاعات امدادرسان',
                                  summary:
                                      '${_text(details.emdadgarFullName)} | ${_text(details.personInfoMobile)}',
                                  children: [
                                    _InfoRow(
                                      label: 'نام امدادرسان',
                                      value: details.emdadgarFullName,
                                    ),
                                    _InfoRow(
                                      label: 'شماره موبایل',
                                      value: details.personInfoMobile,
                                      ltr: true,
                                    ),
                                  ],
                                ),
                                Space.h16,
                                Container(
                                  padding: const EdgeInsets.all(AppPadding.p16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    borderRadius: BorderRadius.circular(AppSize.s12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.04),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'اطلاعات درخواست',
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Space.h16,
                                      Divider(height: AppSize.s1, thickness: AppSize.s1, color: Theme.of(context).colorScheme.tertiaryFixed,),
                                      Space.h16,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: _InfoPair(
                                              label: 'نوع مرخصی',
                                              value: details.leaveTypeText,
                                            ),
                                          ),
                                          Expanded(
                                            child: _InfoPair(
                                              label: 'وضعیت',
                                              customValue: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: LeaveStatusBadge(
                                                  statusCode:
                                                      details.statusCode,
                                                  title: details.statusText,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _InfoPair(
                                              label: 'علت اصلی',
                                              value: details.mainReasonText,
                                            ),
                                          ),
                                          Expanded(
                                            child: _InfoPair(
                                              label: 'علت فرعی',
                                              value:
                                                  details.secondaryReasonText,
                                            ),
                                          ),

                                        ],
                                      ),
                                      Space.h12,
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppPadding.p16,
                                          vertical: AppPadding.p12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF1F1F1),
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s8),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: _DateBlock(
                                                title: 'از تاریخ',
                                                value: details.startDateTime,
                                              ),
                                            ),
                                            Space.w8,
                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xFF777777),
                                            ),
                                              Space.w8,
                                              Expanded(
                                                child: _DateBlock(
                                                  title: 'تا تاریخ',
                                                  value: details.endDateTime,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Space.h16,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'توضیحات',
                                            textAlign: TextAlign.right,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: const Color(0xFF555555),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Space.h8,
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                                                  color: const Color(0xFFF1F1F1),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(AppPadding.p8),
                                                  child: Text(
                                                    _text(details.description),
                                                    textAlign: TextAlign.right,
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: const Color(0xFF1F1F1F),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _BottomActions(id: id, statusCode: details.statusCode),
                      ],
                    ),
        );
      },
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.id,
    required this.statusCode,
  });

  final int id;
  final int? statusCode;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeaveCubit>();
    final status = LeaveStatus.fromCode(statusCode);

    return BlocBuilder<LeaveCubit, LeaveState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (status.canChangeToFinalState) ...[
                  InkwellButtonWidget(
                    title: 'تایید درخواست',
                    backgroundColor: const Color(0xFF59B45C),
                    showLoading: state.isActionLoading,
                    prefixIcon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      final approved =
                          await LeaveActionDialogs.confirmApprove(context);
                      if (approved && context.mounted) {
                        cubit.approveRequest(id);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  InkwellButtonWidget(
                    title: 'رد درخواست',
                    backgroundColor: Colors.white,
                    titleColor: ColorLightManager.error,
                    borderColor: ColorLightManager.error,
                    showLoading: state.isActionLoading,
                    prefixIcon: const Icon(
                      Icons.cancel_outlined,
                      color: ColorLightManager.error,
                    ),
                    onTap: () async {
                      final reason =
                          await LeaveActionDialogs.rejectionReason(context);
                      if (reason != null && context.mounted) {
                        cubit.rejectRequest(id: id, reason: reason);
                      }
                    },
                  ),
                ] else if (status.canRollback)
                  InkwellButtonWidget(
                    title: 'تغییر وضعیت به ثبت شده',
                    backgroundColor: const Color(0xFFDB950C),
                    showLoading: state.isActionLoading,
                    prefixIcon: const Icon(
                      Icons.undo_rounded,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      final confirmed =
                          await LeaveActionDialogs.confirmRollback(context);
                      if (confirmed && context.mounted) {
                        cubit.rollbackRequest(id);
                      }
                    },
                  ),
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () => context.pop(false),
                  child: const BodyMediumText(text: 'انصراف'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CollapsedInfoTile extends StatelessWidget {
  const _CollapsedInfoTile({
    required this.title,
    required this.summary,
    required this.children,
  });

  final String title;
  final String? summary;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _text(summary),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF777777),
                    ),
              ),
            ),
          ],
        ),
        children: children,
      ),
    );
  }
}

class _InfoPair extends StatelessWidget {
  const _InfoPair({
    required this.label,
    this.value,
    this.customValue,
  });

  final String label;
  final String? value;
  final Widget? customValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF555555),
                  fontWeight: FontWeight.w600,
                ),
          ),
          Space.h8,
          customValue ??
              Text(
                _text(value),
                textDirection:  TextDirection.rtl,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF1F1F1F),
                      fontWeight: FontWeight.w500,
                    ),
              ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    this.value,
    this.ltr = false,
  });

  final String label;
  final String? value;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF555555),
              fontWeight: FontWeight.w600,
            ),
          ),
          Space.w8,
          Text(
            _text(value),
            textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF1F1F1F),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF555555),
              ),
        ),
        Space.h8,
        Text(
          _text(value),
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF1F1F1F),
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

String _text(String? value) {
  return value?.trim().isNotEmpty == true ? value! : '---';
}
