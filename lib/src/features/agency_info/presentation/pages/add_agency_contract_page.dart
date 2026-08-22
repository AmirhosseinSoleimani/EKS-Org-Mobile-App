import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_contract/add_agency_contract_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/add_contract/add_agency_contract_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/upload_file.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddAgencyContractPage extends StatelessWidget {
  static const path = '/add-agency-contract-page';
  static const name = 'add-agency-contract-page';

  const AddAgencyContractPage({super.key, required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddAgencyContractCubit>(),
      child: _AddAgencyContractView(agency: agency),
    );
  }
}

class _AddAgencyContractView extends StatelessWidget {
  const _AddAgencyContractView({required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAgencyContractCubit>();

    return BlocConsumer<AddAgencyContractCubit, AddAgencyContractState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.connectionError != current.connectionError ||
          previous.createdId != current.createdId,
      listener: (context, state) => _handleState(context, state, cubit),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: const SimpleAppBar(title: 'ثبت قرار داد جدید'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppPadding.p16,
              AppPadding.p16,
              AppPadding.p16,
              AppPadding.p24,
            ),
            child: FormSectionContainer(
              padding: const EdgeInsets.all(AppSize.s22),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _AgencySummary(agency: agency),
                    Space.h20,
                    _ContractFormFields(cubit: cubit),
                    Space.h32,
                    _ContractFileField(cubit: cubit),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: StickyFormActionBar(
            submitTitle: 'ثبت',
            cancelTitle: 'انصراف',
            isSubmitting: state.isSubmitting,
            onSubmit: () => cubit.submit(agency),
            onCancel: () => context.pop(false),
          ),
        );
      },
    );
  }

  void _handleState(
    BuildContext context,
    AddAgencyContractState state,
    AddAgencyContractCubit cubit,
  ) {
    if (state.createdId != null) {
      context.pop(true);
      return;
    }

    if (state.errorMessage != null) {
      BottomSheetMessage.showError(
        context: context,
        data: BottomSheetMessageModel(
          title: 'خطا',
          message: state.errorMessage!,
        ),
        onButtonTap: () => Navigator.of(context).pop(),
      );
      return;
    }

    if (state.connectionError) {
      BottomSheetMessage.showCustom(
        context: context,
        content: NoInternetBottomSheet(onRetry: () => cubit.submit(agency)),
        actionWidget: const SizedBox.shrink(),
        isDismissible: false,
        enableDrag: false,
      );
    }
  }
}

class _AgencySummary extends StatelessWidget {
  const _AgencySummary({required this.agency});

  final AgencyInfoEntity agency;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          Icons.store_mall_directory_outlined,
          color: colorScheme.primary,
        ),
        Space.w12,
        const Expanded(
          child: BodyMediumText(
            text: 'اطلاعات قرارداد',
            fontWeight: FontWeight.w800,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ContractFormFields extends StatelessWidget {
  const _ContractFormFields({required this.cubit});

  final AddAgencyContractCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormFieldWidget(
          controller: cubit.titleController,
          labelText: 'عنوان',
          validator: cubit.validateRequired,
        ),
        Space.h16,
        TextFormFieldWidget(
          controller: cubit.contractNoController,
          labelText: 'شماره قرارداد',
          validator: cubit.validateRequired,
          textInputType: TextInputType.text,
        ),
        Space.h16,
        DatePickerWidget(
          controller: cubit.startDateController,
          labelText: 'تاریخ شروع',
          hintText: '',
          validator: cubit.validateRequired,
          lastDate: Jalali(1500, 12, 29),
          onTap: cubit.setStartDate,
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: Color(0xFFA4A4A4),
          ),
        ),
        Space.h16,
        DatePickerWidget(
          controller: cubit.expireDateController,
          labelText: 'تاریخ پایان',
          hintText: '',
          validator: cubit.validateRequired,
          lastDate: Jalali(1500, 12, 29),
          onTap: cubit.setExpireDate,
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: Color(0xFFA4A4A4),
          ),
        ),
      ],
    );
  }
}

class _ContractFileField extends StatelessWidget {
  const _ContractFileField({required this.cubit});

  final AddAgencyContractCubit cubit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BodyMediumText(
          text: 'بارگذاری مستندات',
          fontWeight: FontWeight.w500,
          color: colorScheme.onPrimaryFixed,
        ),
        Space.h16,
        UploadFileField(
          type: UploadFileType.attachment,
          isRequired: true,
          requiredMessage: 'انتخاب مستندات قرارداد اجباری است',
          selectedFileSubtitle: 'مستند قرارداد انتخاب شد',
          onChanged: cubit.setFile,
        ),
      ],
    );
  }
}
