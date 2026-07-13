import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_details_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgencyInfoDetailsPage extends StatelessWidget {
  static const path = '/agency-info-details-page';
  static const name = 'agency-info-details-page';

  const AgencyInfoDetailsPage({
    super.key,
    this.id,
    this.item,
  });

  final int? id;
  final AgencyInfoEntity? item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<AgencyInfoCubit>();
        if (item != null) {
          cubit.selectAgency(item!);
        } else if (id != null) {
          cubit.loadDetail(id!);
        }
        return cubit;
      },
      child: const _AgencyInfoDetailsView(),
    );
  }
}

class _AgencyInfoDetailsView extends StatelessWidget {
  const _AgencyInfoDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'جزئیات نمایندگی'),
      body: BlocBuilder<AgencyInfoCubit, AgencyInfoState>(
        builder: (context, state) {
          final data = state.data;
          final item = data.selectedAgency;
          if (data.loadingDetailId != null && item == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (item == null) {
            return const Center(child: Text('اطلاعات نمایندگی یافت نشد.'));
          }
          return AgencyInfoDetailsSection(item: item);
        },
      ),
    );
  }
}
