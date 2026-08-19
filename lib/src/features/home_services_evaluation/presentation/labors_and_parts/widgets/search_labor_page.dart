import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/searchable_dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'labor_registration_page.dart';

class SearchLaborHomeServicePage extends StatelessWidget {
  const SearchLaborHomeServicePage({super.key, required this.serviceIndex});
  final int serviceIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<LaborsAndPartsCubit>();
        bloc.initState();
        return bloc;
      },
      child: Builder(
        builder: (context) {
          return _build(context);
        }
      ),
    );
  }

  Widget _build(BuildContext context) {
    final cubit = context.read<LaborsAndPartsCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SimpleAppBar(title: 'افزودن سایر خدمات'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<LaborsAndPartsCubit, LaborsAndPartsState>(
          listener: (context, state) => state.whenOrNull(
            error: (bottomSheetMessage) {
              return BottomSheetMessage.showError(
                context: context,
                data: bottomSheetMessage,
                isDismissible: true,
                enableDrag: true,
                onButtonTap: () => context.pop(),
              );
            },
          ),
          builder: (BuildContext context, state) {
            final isLaborLoading = state.maybeWhen(
                laborLoading: () => true,
                orElse: () => false);
            return StreamBuilder<List<LaborResponseEntity?>>(
              stream: cubit.laborResponseListSubject,
              builder: (context, snapshot) {
                final items =
                    snapshot.data?.whereType<LaborResponseEntity>().toList() ??
                        [];

                return SearchableDropdownSelector<LaborResponseEntity>(
                  label: 'نام اجرت',
                  hintText: 'حداقل ۳ کاراکتر وارد کنید',
                  controller: cubit.searchLaborController,

                  selectedNotifier: ValueNotifier(
                      cubit.selectLaborResponseEntity),

                  items: items,
                  isLoading: isLaborLoading,

                  itemTitleBuilder: (item) => item.name ?? '',

                  onSearchChanged: (query) {
                    if (query.length >= 3) {
                      cubit.getLabors(value: query, serviceIndex: serviceIndex);
                    }
                  },

                  onSelect: (item) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                        LaborRegistrationPage(
                          serviceIndex: serviceIndex,
                          entity: item,
                        ),
                    ));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
