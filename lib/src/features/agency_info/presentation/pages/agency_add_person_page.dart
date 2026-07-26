import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_state.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_person/add_agency_person_form_sheet.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_person/add_agency_person_search_card.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_person/add_agency_person_search_results.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AgencyAddPersonPage extends StatelessWidget {
  static const path = '/agency-add-person-page';
  static const name = 'agency-add-person-page';

  const AgencyAddPersonPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddAgencyPersonCubit>(),
      child: _AgencyAddPersonView(agency: agency),
    );
  }
}

class _AgencyAddPersonView extends StatelessWidget {
  const _AgencyAddPersonView({required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAgencyPersonCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AddAgencyPersonCubit, AddAgencyPersonState>(
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
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: const SimpleActionBar(title: 'ثبت امدادرسان جدید'),
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p24,
                  AppPadding.p16,
                  AppPadding.p24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AddAgencyPersonSearchCard(
                      cubit: cubit,
                      state: state,
                    ),
                    Space.h24,
                    AddAgencyPersonSearchResults(
                      state: state,
                      onAdd: (person) => _openFormSheet(
                        context,
                        cubit,
                        person,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration:  BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SafeArea(
                minimum: const EdgeInsets.all(AppPadding.p16),
                child: InkwellButtonWidget(
                  title: 'بستن',
                  onTap: () => context.pop(false),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  titleColor: Theme.of(context).colorScheme.onSurface,
                  borderColor: Theme.of(context).colorScheme.outline,
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
    AddAgencyPersonCubit cubit,
    PersonInfoSearchEntity person,
  ) async {
    cubit.selectPerson(person);

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: AddAgencyPersonFormSheet(agency: agency),
        );
      },
    );

    if (result == true && context.mounted) {
      context.pop(true);
    }
  }
}
