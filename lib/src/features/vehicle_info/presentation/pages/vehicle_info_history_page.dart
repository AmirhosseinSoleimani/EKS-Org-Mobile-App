import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleInfoHistoryPage extends StatelessWidget {
  static const path = '/vehicle-info-history-page';
  static const name = 'vehicle-info-history-page';

  const VehicleInfoHistoryPage({super.key, required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<VehicleInfoCubit>();
        final id = item.id;
        if (id != null) {
          cubit.loadHistory(refId: id, type: 2);
        }
        return cubit;
      },
      child: _VehicleInfoHistoryView(item: item),
    );
  }
}

class _VehicleInfoHistoryView extends StatelessWidget {
  const _VehicleInfoHistoryView({required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleInfoCubit, VehicleInfoState>(
      listener: (context, state) {
        final error = state.data.errorMessage;
        if (error != null && error.isNotEmpty) {
          SnakeBarWidget.showError(context: context, message: error);
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'تاریخچه'),
          backgroundColor: const Color(0xFFF4F4F4),
          body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              final data = state.data;
              final isLoading = data.loadingHistoryRefId != null;
              return ListView(
                padding: const EdgeInsets.all(AppPadding.p16),
                children: [
                  _VehicleHistoryHeaderCard(item: item),
                  Space.h24,
                  if (isLoading)
                    const SizedBox(
                      height: AppSize.s300,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (data.histories.isEmpty)
                    Center(child: const EmptyListWidget())
                  else
                    ...data.histories.map((history) => Padding(
                          padding: const EdgeInsets.only(bottom: AppPadding.p12),
                          child: _HistoryTile(history: history),
                        )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VehicleHistoryHeaderCard extends StatelessWidget {
  const _VehicleHistoryHeaderCard({required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p14,
        AppPadding.p16,
        AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نوع وسیله نقلیه',
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF707070),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            item.title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF151515),
              fontWeight: FontWeight.w800,
            ),
          ),
          Space.h12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (item.licensePlate?.trim().isNotEmpty == true)
                VehicleLicensePlateView(licensePlate: item.licensePlate!),
              const Spacer(),
              _InfoColumn(title: 'شماره شاسی', value: item.chassisNumber),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({
    required this.title,
    required this.value,
  });

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayValue = value?.trim().isNotEmpty == true ? value!.trim() : '---';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF707070),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          displayValue,
          textDirection: TextDirection.ltr,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF202020),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.history});

  final VehicleHistoryEntity history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE4E4E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history_rounded, size: AppSize.s20, color: theme.colorScheme.primary),
              Space.w8,
              Expanded(
                child: Text(
                  _actionTitle(history.actionType),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                _dash(history.insertDateTimeJalali),
                textDirection: TextDirection.ltr,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF777777),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Space.h12,
          Text(
            _dash(history.description),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF202020),
              height: 1.7,
              fontWeight: FontWeight.w600,
            ),
          ),
          Space.h12,
          Row(
            children: [
              _MetaChip(title: _dash(history.entityTypeTitle)),
              Space.w8,
              _MetaChip(title: 'کاربر: ${_dash(history.insertUserName)}'),
            ],
          ),
        ],
      ),
    );
  }

  String _actionTitle(int? value) {
    switch (value) {
      case 1:
        return 'ثبت';
      case 2:
        return 'ویرایش';
      case 3:
        return 'حذف';
      default:
        return 'تاریخچه';
    }
  }

  String _dash(String? value) => value?.trim().isNotEmpty == true ? value!.trim() : '---';
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF666666),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
