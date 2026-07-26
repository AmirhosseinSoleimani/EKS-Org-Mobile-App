import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_state.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_flow/agency_add_search_card.dart';
import 'package:flutter/material.dart';

class AddAgencyPersonSearchCard extends StatelessWidget {
  const AddAgencyPersonSearchCard({
    super.key,
    required this.cubit,
    required this.state,
  });

  final AddAgencyPersonCubit cubit;
  final AddAgencyPersonState state;

  @override
  Widget build(BuildContext context) {
    return AgencyAddSearchCard(
      controller: cubit.searchController,
      message: 'برای مشاهده امدادرسان‌ها ابتدا جستجو کنید',
      hintText: 'براساس نام،نام‌خانوادگی، کدملی، موبایل',
      isLoading: state.isSearching,
      onSearch: cubit.search,
    );
  }
}
