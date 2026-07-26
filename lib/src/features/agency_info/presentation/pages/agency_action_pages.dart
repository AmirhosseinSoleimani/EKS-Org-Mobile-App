import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_additional_information_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_person_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_service_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_add_person_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_active_relief_workers_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_active_vehicles_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_complementary_info_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_history_action_view.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/action_views/agency_info_service_type_action_view.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AgencyActiveReliefWorkersPage extends StatelessWidget {
  static const path = '/agency-active-relief-workers-page';
  static const name = 'agency-active-relief-workers-page';

  const AgencyActiveReliefWorkersPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return _AgencyActionDataPage(
      title: 'امدادرسان‌های فعلی',
      agency: agency,
      actionType: AgencyInfoActionType.activeReliefWorkers,
      builder: (context, data) {
        final persons = data is AgencyPersonPageEntity
            ? data
            : const AgencyPersonPageEntity(records: [], count: 0);
        return AgencyInfoActiveReliefWorkersActionView(
          item: agency,
          persons: persons,
          showSectionHeader: false,
        );
      },
      floatingActionButtonBuilder: (context, cubit) {
        return FloatingActionButtonWidget(
          title: 'امداد رسان جدید',
          onPressed: () async {
            final result = await context.pushNamed<bool>(
              AgencyAddPersonPage.name,
              extra: agency,
            );
            if (result == true && context.mounted) {
              await cubit.loadActionData(
                AgencyInfoActionType.activeReliefWorkers,
                agency,
              );
            }
          },
        );
      },
    );
  }
}

class AgencyActiveVehiclesPage extends StatelessWidget {
  static const path = '/agency-active-vehicles-page';
  static const name = 'agency-active-vehicles-page';

  const AgencyActiveVehiclesPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return _AgencyActionDataPage(
      title: 'خودروهای فعلی',
      agency: agency,
      actionType: AgencyInfoActionType.activeVehicles,
      builder: (context, data) {
        final vehicles = data is AgencyVehiclePageEntity
            ? data
            : const AgencyVehiclePageEntity(records: [], count: 0);
        return AgencyInfoActiveVehiclesActionView(
          item: agency,
          vehicles: vehicles,
          showSectionHeader: false,
        );
      },
    );
  }
}

class AgencyServiceTypesPage extends StatelessWidget {
  static const path = '/agency-service-types-page';
  static const name = 'agency-service-types-page';

  const AgencyServiceTypesPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return _AgencyActionDataPage(
      title: 'نوع خدمات',
      agency: agency,
      actionType: AgencyInfoActionType.serviceType,
      builder: (context, data) {
        final serviceTypes = data is List<AgencyServiceTypeEntity>
            ? data
            : const <AgencyServiceTypeEntity>[];
        return AgencyInfoServiceTypeActionView(
          item: agency,
          serviceTypes: serviceTypes,
        );
      },
    );
  }
}

class AgencyComplementaryInfoPage extends StatelessWidget {
  static const path = '/agency-complementary-info-page';
  static const name = 'agency-complementary-info-page';

  const AgencyComplementaryInfoPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return _AgencyActionDataPage(
      title: 'اطلاعات تکمیلی',
      agency: agency,
      actionType: AgencyInfoActionType.complementaryInfo,
      builder: (context, data) {
        final information = data is AgencyAdditionalInformationEntity
            ? data
            : null;

        return AgencyInfoComplementaryInfoActionView(
          item: agency,
          information: information,
        );
      },
    );
  }
}

class AgencyHistoryPage extends StatelessWidget {
  static const path = '/agency-history-page';
  static const name = 'agency-history-page';

  const AgencyHistoryPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return _AgencyActionDataPage(
      title: 'تاریخچه',
      agency: agency,
      actionType: AgencyInfoActionType.history,
      builder: (context, data) {
        final histories = data is List<AgencyHistoryEntity>
            ? data
            : const <AgencyHistoryEntity>[];
        return AgencyInfoHistoryActionView(
          item: agency,
          histories: histories,
        );
      },
    );
  }
}

typedef _AgencyActionDataBuilder = Widget Function(
  BuildContext context,
  Object? data,
);

typedef _AgencyActionFloatingButtonBuilder = Widget? Function(
  BuildContext context,
  AgencyInfoCubit cubit,
);

class _AgencyActionDataPage extends StatelessWidget {
  const _AgencyActionDataPage({
    required this.title,
    required this.agency,
    required this.actionType,
    required this.builder,
    this.floatingActionButtonBuilder,
  });

  final String title;
  final AgencyInfoEntity agency;
  final AgencyInfoActionType actionType;
  final _AgencyActionDataBuilder builder;
  final _AgencyActionFloatingButtonBuilder? floatingActionButtonBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AgencyInfoCubit>()..loadActionData(actionType, agency),
      child: _AgencyActionDataView(
        title: title,
        agency: agency,
        actionType: actionType,
        builder: builder,
        floatingActionButtonBuilder: floatingActionButtonBuilder,
      ),
    );
  }
}

class _AgencyActionDataView extends StatelessWidget {
  const _AgencyActionDataView({
    required this.title,
    required this.agency,
    required this.actionType,
    required this.builder,
    this.floatingActionButtonBuilder,
  });

  final String title;
  final AgencyInfoEntity agency;
  final AgencyInfoActionType actionType;
  final _AgencyActionDataBuilder builder;
  final _AgencyActionFloatingButtonBuilder? floatingActionButtonBuilder;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AgencyInfoCubit>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: SimpleAppBar(title: title),
      floatingActionButton: floatingActionButtonBuilder?.call(context, cubit),
      body: BlocConsumer<AgencyInfoCubit, AgencyInfoState>(
        listener: (context, state) {
          final message = state.data.errorMessage;
          if (message?.isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: message!);
          }
        },
        builder: (context, state) {
          final isLoading = state.status == AgencyInfoViewStatus.actionLoading &&
              state.data.actionType == actionType;

          if (isLoading && state.data.actionData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => cubit.loadActionData(actionType, agency),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p16,
                0,
              ),
              child: builder(context, state.data.actionData),
            ),
          );
        },
      ),
    );
  }
}
