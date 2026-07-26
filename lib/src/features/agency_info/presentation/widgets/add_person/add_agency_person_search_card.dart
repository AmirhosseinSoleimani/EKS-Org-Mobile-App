import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_state.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/search_input_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return AgencyInfoActionCard(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: AppSize.s18,
                color: colorScheme.onSurfaceVariant,
              ),
              Space.w8,
              BodyMediumText(
                text: 'برای مشاهده امدادرسان‌ها ابتدا جستجو کنید',
                color: colorScheme.onPrimaryFixedVariant,
              ),
            ],
          ),
          Space.h16,
          SearchInputField(
            controller: cubit.searchController,
            hintText: 'براساس نام،نام‌خانوادگی، کدملی، موبایل',
            hintColor: const Color(0xFFA4A4A4),
            floatingLabelBehavior:  FloatingLabelBehavior.always,
            labelText: 'جستجو',
            labelColor: colorScheme.onPrimaryFixed,
          ),
          Space.h16,
          InkwellButtonWidget(
            title: 'جستجو',
            showLoading: state.isSearching,
            onTap: cubit.search,
            backgroundColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
