import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/cubit/grade_pattern_cubit.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_level_form_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GradePatternFormPage extends StatelessWidget {
  static const path = '/grade-pattern-form-page';
  static const name = 'grade-pattern-form-page';

  const GradePatternFormPage({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GradePatternCubit>()..loadForm(id: id),
      child: const _GradePatternFormView(),
    );
  }
}

class _GradePatternFormView extends StatefulWidget {
  const _GradePatternFormView();

  @override
  State<_GradePatternFormView> createState() => _GradePatternFormViewState();
}

class _GradePatternFormViewState extends State<_GradePatternFormView> {
  final _nameController = TextEditingController();
  final _coefficientControllers = <int, TextEditingController>{};
  final _commissionControllers = <int, TextEditingController>{};
  GradePatternEntity? _item;
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    for (final controller in _coefficientControllers.values) {
      controller.dispose();
    }
    for (final controller in _commissionControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GradePatternCubit>();

    return BlocListener<GradePatternCubit, GradePatternState>(
      listener: (context, state) {
        state.whenOrNull(
          formReady: _setInitialValue,
          failure: (message, items) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          success: (action, message, items) {
            SnakeBarWidget.showSuccess(context: context, message: message);
            context.pop(true);
          },
        );
      },
      child: BlocBuilder<GradePatternCubit, GradePatternState>(
        builder: (context, state) {
          final isSubmitting = state.maybeWhen(
            submitting: (_, __) => true,
            orElse: () => false,
          );
          final item = _item;
          final isNew = item?.id == null || item?.id == 0;
          return Scaffold(
            backgroundColor: const Color(0xFFF8F7F7),
            appBar: SimpleAppBar(
              title: isNew ? 'افزودن الگوی گرید' : 'ویرایش الگوی گرید',
            ),
            bottomNavigationBar: item == null
                ? null
                : SafeArea(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(14),
                            blurRadius: 12,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkwellButtonWidget(
                                title: isNew ? 'افزودن' : 'ثبت تغییرات',
                                showLoading: isSubmitting,
                                borderRadius: AppSize.s8,
                                onTap: () => _submit(cubit),
                              ),
                            ),
                            Space.w12,
                            Expanded(
                              child: InkwellButtonWidget(
                                title: 'انصراف',
                                backgroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                titleColor:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                                borderRadius: AppSize.s8,
                                onTap: () => context.pop(false),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            body: state.maybeWhen(
              detailLoading: (_) => const Center(child: CircularProgressIndicator()),
              connectionError: (_, __) => const Center(
                child: Text('اتصال به اینترنت برقرار نیست'),
              ),
              orElse: () {
                if (item == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p16,
                    AppPadding.p24,
                    AppPadding.p16,
                    AppPadding.p24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormFieldWidget(
                        controller: _nameController,
                        labelText: 'عنوان',
                      ),
                      Space.h24,
                      Text(
                        'تعیین مقادیر سطوح',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF574235),
                            ),
                      ),
                      Space.h16,
                      if (item.details.isEmpty)
                        const _EmptyGradeLevels()
                      else
                        ...item.details.map(_buildDetailEditor),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _setInitialValue(GradePatternEntity item) {
    if (_item?.id == item.id && _item?.details.length == item.details.length) {
      return;
    }
    _item = item;
    _nameController.text = item.name ?? '';
    _isActive = item.isActive;
    for (final detail in item.details) {
      _coefficientControllers[detail.gradeId] = TextEditingController(
        text: detail.gradeCoefficient.toString(),
      );
      _commissionControllers[detail.gradeId] = TextEditingController(
        text: detail.managmentCommisionPercent.toString(),
      );
    }
    setState(() {});
  }

  Widget _buildDetailEditor(GradePatternDetailEntity detail) {
    final coefficientController = _coefficientControllers.putIfAbsent(
      detail.gradeId,
      () => TextEditingController(
        text: detail.gradeCoefficient.toString(),
      ),
    );
    final commissionController = _commissionControllers.putIfAbsent(
      detail.gradeId,
      () => TextEditingController(
        text: detail.managmentCommisionPercent.toString(),
      ),
    );

    return GradePatternLevelFormCard(
      detail: detail,
      coefficientController: coefficientController,
      commissionController: commissionController,
    );
  }

  Future<void> _submit(GradePatternCubit cubit) async {
    final item = _item;
    if (item == null) return;
    final details = item.details.map((detail) {
      return detail.copyWith(
        gradeCoefficient: num.tryParse(
              _coefficientControllers[detail.gradeId]?.text.trim() ?? '',
            ) ??
            0,
        managmentCommisionPercent: num.tryParse(
              _commissionControllers[detail.gradeId]?.text.trim() ?? '',
            ) ??
            0,
      );
    }).toList();

    await cubit.submit(item.copyWith(
      name: _nameController.text.trim(),
      isActive: _isActive,
      details: details,
    ));
  }
}

class _EmptyGradeLevels extends StatelessWidget {
  const _EmptyGradeLevels();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
      child: Text(
        'سطحی برای این الگو تعریف نشده است',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
