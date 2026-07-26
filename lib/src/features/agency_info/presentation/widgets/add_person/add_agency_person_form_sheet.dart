import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_person/add_agency_person_state.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_agency/add_agency_bottom_actions.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/add_person/agency_person_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddAgencyPersonFormSheet extends StatelessWidget {
  const AddAgencyPersonFormSheet({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAgencyPersonCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AddAgencyPersonCubit, AddAgencyPersonState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.status == AddAgencyPersonStatus.submitSuccess) {
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: FullScreenBottomSheetAppBar(
                title: 'ثبت امدادرسان جدید',
                onClose: () => Navigator.of(context).pop(false),
              ),
            ),
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
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _SelectedPersonSectionTitle(),
                      Space.h12,
                      if (state.selectedPerson != null)
                        AgencyPersonSummaryCard(
                          person: state.selectedPerson!,
                          compact: true,
                        ),
                      Space.h24,
                      _CooperationForm(cubit: cubit, state: state),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: AddAgencyBottomActions(
              isSubmitting: state.isSubmitting,
              submitTitle: 'ثبت',
              onCancel: () => Navigator.of(context).pop(false),
              onSubmit: () => cubit.submit(agency),
            ),
          );
        },
      ),
    );
  }
}

class _SelectedPersonSectionTitle extends StatelessWidget {
  const _SelectedPersonSectionTitle();

  @override
  Widget build(BuildContext context) {
    return TitleLargeText(
      text: 'امدادرسان انتخاب شده',
      color: Theme.of(context).colorScheme.onTertiaryFixed,
      fontSize: AppSize.s16,
    );
  }
}

class _CooperationForm extends StatelessWidget {
  const _CooperationForm({
    required this.cubit,
    required this.state,
  });

  final AddAgencyPersonCubit cubit;
  final AddAgencyPersonState state;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: colorScheme.primary,
              ),
              Space.w8,
              Expanded(
                child: BodyMediumText(
                  text: 'اطلاعات همکاری',
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                  fontSize: AppSize.s16,
                ),
              ),
            ],
          ),
          Space.h20,
          TextFormFieldWidget(
            controller: cubit.jobPositionController,
            labelText: 'عنوان شغل',
            mandatory: true,
            validator: cubit.validateRequired,
          ),
          Space.h16,
          DatePickerWidget(
            controller: cubit.contractStartDateController,
            labelText: 'تاریخ شروع همکاری',
            hintText: '',
            mandatory: true,
            validator: cubit.validateRequired,
            lastDate: Jalali(1500, 12, 29),
            onTap: cubit.setContractStartDate,
            suffixIcon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFFA4A4A4),
            ),
          ),
          Space.h16,
          DatePickerWidget(
            controller: cubit.contractEndDateController,
            labelText: 'تاریخ اتمام همکاری',
            hintText: '',
            lastDate: Jalali(1500, 12, 29),
            onTap: cubit.setContractEndDate,
            suffixIcon: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFFA4A4A4),
            ),
          ),
          Space.h16,
          TextFormFieldWidget(
            controller: cubit.aidPersonMobileController,
            labelText: 'شماره موبایل واحد امدادی',
            textInputType: TextInputType.phone,
            validator: cubit.validateMobile,
          ),
          Space.h16,
          Row(
            children: [
              Expanded(
                child: OverlayDropdownFormField<SimpleDropdownItem<String>>(
                  labelText: 'نوع فعالیت',
                  mandatory: true,
                  items: _activityItems,
                  value: _activityItems.firstWhere(
                    (item) => item.value == state.activityType,
                    orElse: () => _activityItems.first,
                  ),
                  onChanged: (item) {
                    if (item != null) cubit.setActivityType(item.value);
                  },
                ),
              ),
              Space.w12,
              Expanded(
                child: OverlayDropdownFormField<SimpleDropdownItem<bool>>(
                  labelText: 'وضعیت',
                  mandatory: true,
                  items: _statusItems,
                  value: _statusItems.firstWhere(
                    (item) => item.value == state.isActive,
                    orElse: () => _statusItems.first,
                  ),
                  onChanged: (item) {
                    if (item != null) cubit.setIsActive(item.value);
                  },
                ),
              ),
            ],
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: cubit.descriptionController,
            labelText: 'توضیحات',
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  static const _activityItems = [
    SimpleDropdownItem<String>(value: '1', label: 'تمام وقت'),
    SimpleDropdownItem<String>(value: '2', label: 'پاره وقت'),
  ];

  static const _statusItems = [
    SimpleDropdownItem<bool>(value: true, label: 'فعال'),
    SimpleDropdownItem<bool>(value: false, label: 'غیرفعال'),
  ];
}
