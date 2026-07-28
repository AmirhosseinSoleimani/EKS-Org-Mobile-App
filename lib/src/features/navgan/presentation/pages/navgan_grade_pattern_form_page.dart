import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavganGradePatternFormPageArgs {
  const NavganGradePatternFormPageArgs({
    required this.navgan,
  });

  final NavganEntity navgan;
}

class NavganGradePatternFormPage extends StatelessWidget {
  static const path = '/navgan-grade-pattern-form-page';
  static const name = 'navgan-grade-pattern-form-page';

  const NavganGradePatternFormPage({
    super.key,
    required this.navgan,
  });

  final NavganEntity navgan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NavganCubit>()..prepareGradeSheet(navgan),
      child: const _NavganGradePatternFormView(),
    );
  }
}

class _NavganGradePatternFormView extends StatefulWidget {
  const _NavganGradePatternFormView();

  @override
  State<_NavganGradePatternFormView> createState() =>
      _NavganGradePatternFormViewState();
}

class _NavganGradePatternFormViewState
    extends State<_NavganGradePatternFormView> {
  GradePatternEntity? _selectedPattern;
  ServiceType? _selectedServiceType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavganCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<NavganCubit, NavganState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage,
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
          }

          final success = state.successMessage;
          if (success?.trim().isNotEmpty == true) {
            SnakeBarWidget.showSuccess(context: context, message: success!);
            context.pop(true);
          }
        },
        builder: (context, state) {
          final isLoading = state.isGradePatternsLoading;

          return Scaffold(
            backgroundColor: const Color(0xFFF8F7F7),
            appBar: const SimpleAppBar(title: 'ثبت الگوی گرید'),
            body: SafeArea(
              top: false,
              child: isLoading
                  ? const Center(child: LoadingWidget())
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p16,
                        AppPadding.p24,
                        AppPadding.p16,
                        AppPadding.p24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OverlayDropdownFormField<GradePatternEntity>(
                            labelText: 'الگوی گرید',
                            mandatory: true,
                            items: state.gradePatterns,
                            value: _selectedPattern,
                            enabled: state.gradePatterns.isNotEmpty,
                            hintText: state.gradePatterns.isEmpty
                                ? 'الگویی وجود ندارد'
                                : 'انتخاب کنید',
                            onChanged: (value) {
                              setState(() => _selectedPattern = value);
                            },
                          ),
                          Space.h20,
                          OverlayDropdownFormField<ServiceType>(
                            labelText: 'نوع خدمت',
                            mandatory: true,
                            items: ServiceType.values,
                            value: _selectedServiceType,
                            onChanged: (value) {
                              setState(() => _selectedServiceType = value);
                            },
                          ),
                        ],
                      ),
                    ),
            ),
            bottomNavigationBar: StickyFormActionBar(
              submitTitle: 'ثبت',
              cancelTitle: 'انصراف',
              isSubmitting: state.isGradeSubmitting,
              onSubmit: () => _submit(context, cubit),
              onCancel: () => context.pop(false),
            ),
          );
        },
      ),
    );
  }

  Future<void> _submit(BuildContext context, NavganCubit cubit) async {
    final pattern = _selectedPattern;
    final serviceType = _selectedServiceType;

    if (pattern == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'الگوی گرید را انتخاب کنید.',
      );
      return;
    }

    if (serviceType == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'نوع خدمت را انتخاب کنید.',
      );
      return;
    }

    await cubit.addGradeReference(
      pattern: pattern,
      serviceTypeId: serviceType.value,
    );
  }
}
