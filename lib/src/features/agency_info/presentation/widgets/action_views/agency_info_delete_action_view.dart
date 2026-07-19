import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgencyInfoDeleteActionView extends StatelessWidget {
  const AgencyInfoDeleteActionView({
    super.key,
    required this.item,
    required this.cubit,
  });

  final AgencyInfoEntity item;
  final AgencyInfoCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          previous.data.deletingAgencyId != current.data.deletingAgencyId,
      builder: (context, state) {
        final isLoading = state.data.deletingAgencyId == item.id;

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p8,
            AppPadding.p8,
            AppPadding.p8,
            AppPadding.p4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppSize.s60,
                height: AppSize.s60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: theme.colorScheme.error,
                  size: AppSize.s28,
                ),
              ),
              Space.h16,
              Text(
                'حذف نمایندگی',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Space.h12,
              Text(
                'آیا نمایندگی ${item.title} حذف شود؟',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  height: 1.6,
                ),
              ),
              Space.h24,
              Row(
                children: [

                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'حذف',
                      backgroundColor: theme.colorScheme.error,
                      titleColor: Colors.white,
                      loadingColor: Colors.white,
                      showLoading: isLoading,
                      onTap: () async {
                        if (isLoading) return;
                        final deleted = await cubit.deleteAgency(item);
                        if (deleted && context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'بستن',
                      backgroundColor: theme.colorScheme.surface,
                      borderColor: theme.colorScheme.outline,
                      titleColor: theme.colorScheme.onSurface,
                      onTap: isLoading
                          ? null
                          : () => Navigator.of(context).pop(),
                    ),
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
