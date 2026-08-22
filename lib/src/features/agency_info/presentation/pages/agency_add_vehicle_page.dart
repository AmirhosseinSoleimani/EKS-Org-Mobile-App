import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_vehicle/add_agency_vehicle_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_vehicle/add_agency_vehicle_state.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_flow/agency_add_search_card.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_flow/agency_add_search_results.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_vehicle/add_agency_vehicle_form_sheet.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_vehicle/agency_vehicle_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AgencyAddVehiclePage extends StatelessWidget {
  static const path = '/agency-add-vehicle-page';
  static const name = 'agency-add-vehicle-page';

  const AgencyAddVehiclePage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddAgencyVehicleCubit>(),
      child: _AgencyAddVehicleView(agency: agency),
    );
  }
}

class _AgencyAddVehicleView extends StatelessWidget {
  const _AgencyAddVehicleView({required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAgencyVehicleCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AddAgencyVehicleCubit, AddAgencyVehicleState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.status != current.status,
        listener: (context, state) {
          final message = state.errorMessage;
          if (message?.isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: message!);
          }
        },
        builder: (context, state) {
          final theme = Theme.of(context);

          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: const SimpleAppBar(title: 'ثبت خودرو جدید'),
            body: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p24,
                  AppPadding.p16,
                  AppPadding.p24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AgencyAddSearchCard(
                      controller: cubit.searchController,
                      message: 'برای مشاهده خودروها ابتدا جستجو کنید',
                      hintText: 'براساس شاسی، موتور، پلاک',
                      isLoading: state.isSearching,
                      onSearch: cubit.search,
                    ),
                    Space.h24,
                    Expanded(
                      child: AgencyAddSearchResults<VehicleInfoSearchEntity>(
                        items: state.vehicles,
                        count: state.searchCount,
                        showEmpty:
                            state.status == AddAgencyVehicleStatus.searchEmpty,
                        itemBuilder: (context, vehicle) {
                          return AgencyVehicleSummaryCard(
                            vehicle: vehicle,
                            onAdd: () => _openFormSheet(
                              context,
                              cubit,
                              vehicle,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SafeArea(
                minimum: const EdgeInsets.all(AppPadding.p16),
                child: InkwellButtonWidget(
                  title: 'بستن',
                  onTap: () => context.pop(false),
                  backgroundColor: theme.colorScheme.surface,
                  titleColor: theme.colorScheme.onSurface,
                  borderColor: theme.colorScheme.outline,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openFormSheet(
    BuildContext context,
    AddAgencyVehicleCubit cubit,
    VehicleInfoSearchEntity vehicle,
  ) async {
    cubit.selectVehicle(vehicle);

    final result = await BottomSheetMessage.showFullScreenCustom<bool>(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: AddAgencyVehicleFormSheet(agency: agency),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    );

    if (result == true && context.mounted) {
      context.pop(true);
    }
  }
}
